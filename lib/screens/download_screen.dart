import 'package:fade_video_app/bloc/download_bloc.dart';
import 'package:fade_video_app/helpers/functions.dart';
import 'package:fade_video_app/models/download.dart';
import 'package:fade_video_app/models/movie.dart';
import 'package:fade_video_app/screens/video_player.dart';
import 'package:fade_video_app/services/movie_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DownloadScreen extends StatefulWidget {
  @override
  _DownloadScreenState createState() => _DownloadScreenState();
}

class _DownloadScreenState extends State<DownloadScreen> {
  @override
  void initState() {
    super.initState();
    var downloadBloc = Provider.of<DownloadBloc>(context, listen: false);
    // this shouldnt have been done, but your app design is ... hmmmm
    MovieService _movieService = MovieService();
    var response = _movieService.getDramaMovies();
    var _list = <Movie>[];
    response['data'].forEach((data) {
      var model = Movie();
      model.id = data['id'];
      model.title = data['title'];
      model.url = data['movie_url'];
      model.thumbnail = data['movie_thumbnail'];
      model.quality = data['movie_quality_id'];
      model.releaseDate = data['release_date'];
      model.genres = data['genres'];
      model.poster = data['movie_poster'];
      model.description = data['description'];
      model.directors = data['directors'];
      model.crew = data['crew'];
      model.downloadUrl = data['download_url'];
      setState(() {
        _list.add(model);
      });
      downloadBloc.getDownloadsOnDevice(_list);
    });
  }

  @override
  Widget build(BuildContext context) {
    var downloadBloc = Provider.of<DownloadBloc>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text('Downloads'),
        ),
        body: downloadBloc.isLoading
            ? Center(
                child: Text('Loading Downloads'),
              )
            : downloadBloc.downloads.isEmpty
                ? Center(
                    child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                            'No downloads found, your downloaded videos would show here',
                            textAlign: TextAlign.center)))
                : ListView(
                    children: downloadBloc.downloads.map((download) {
                    String status;
                    switch (download.status) {
                      case DownloadStatus.Downloaded:
                        status = 'Downloaded';
                        break;
                      case DownloadStatus.Downloading:
                        status =
                            'Downloading ( ${download.progress.toStringAsFixed(0)}% )';
                        break;
                      case DownloadStatus.Failed:
                        status = 'Download failed';
                        break;
                      case DownloadStatus.Queued:
                        status = 'Pending';
                        break;
                      default:
                        status = 'Downloaded';
                    }
                    return ListTile(
                      title: Text('${download.movie.title}'),
                      subtitle: Text('$status'),
                      onTap: () {
                        if (download.status == DownloadStatus.Downloaded) {
                          push(
                              context,
                              Player(
                                movie: download.movie,
                                isYT: isYT(download.movie.downloadUrl),
                              ));
                        }
                      },
                      trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () async {
                            await downloadBloc.delete(download,
                                isYT: isYT(download.movie.downloadUrl));
                          }),
                    );
                  }).toList()));
  }
}
