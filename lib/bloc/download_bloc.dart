import 'dart:io';
import 'package:dio/dio.dart';
import 'package:fade_video_app/helpers/functions.dart';
import 'package:fade_video_app/models/download.dart';
import 'package:fade_video_app/models/movie.dart';
import 'package:fade_video_app/screens/video_player.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class DownloadBloc with ChangeNotifier {
  var yt = YoutubeExplode();
  var storage = new LocalStorage('storage.json');

  List<Download> _downloads = [];
  List<Download> get downloads => _downloads;
  set downloads(List<Download> value) {
    this._downloads = value;
    notifyListeners();
  }

  bool _isLoading = true;
  bool get isLoading => _isLoading;
  set loading(bool value) {
    this._isLoading = value;
    notifyListeners();
  }

  /// pass the list<Movie> from the api through the downloadPipeline
  /// so you'll be able to know which movie has been downloaded or not
  /// check [drama_movies.dart] line 45 for more
  Future<List<Movie>> downloadPipeline(List<Movie> movies) async {
    var downloadDir = await getDownloadDir();
    downloadDir.listSync().forEach((fileSysEntity) {
      String _fileName = getFileNameFromUrl(fileSysEntity.path);
      for (var i = 0; i < movies.length; i++) {
        String __fileName = getFileNameFromUrl(movies[i].downloadUrl);
        String ytId = getYoutubeId(movies[i].downloadUrl); // yt files
        if (_fileName == __fileName || _fileName == ytId) {
          movies[i].isDownloaded = true;
          break;
        }
      }
    });
    return movies;
  }

  // get all the downloads on the user device by checking the name against
  // names of the movies from the api
  void getDownloadsOnDevice() async {
    if (downloads.isEmpty && await storage.ready) {
      List<Download> temp = [];
      List<dynamic> dl = storage.getItem('downloads');
      if (dl != null)
        dl.forEach((d) {
          temp.add(new Download.fromMap(d));
        });
      downloads = temp;
    }
    loading = false;
  }

  // queue movie for download
  void enqueue(BuildContext context, Movie movie, {bool queued = false}) async {
    if (await hasDownloaded(movie, isYT: isYT(movie.downloadUrl))) {
      // movie has already been downloaded, play the movie instead or do something else
      push(
          context,
          Player(
            movie: movie,
            isYT: isYT(movie.downloadUrl),
          ));
    } else {
      var downloadDir = await getDownloadDir();
      String downloadUrl = movie.downloadUrl;
      var savePath = "${downloadDir.path}";
      var filePath =
          "$savePath/${getFileNameFromUrl(downloadUrl)}.${getFileExtFromUrl(downloadUrl)}";
      var dl = new Download(
          movie: movie,
          status: DownloadStatus.Downloading,
          timestamp: new DateTime.now().toString());
      // queue download if not queued
      if (!queued) {
        _downloads.add(dl);
        downloads = _downloads;
      }
      // if the download is queued, reset the download status
      if (queued) {
        _downloads.firstWhere((d) => d.movie.id == movie.id).status =
            DownloadStatus.Downloading;
        downloads = _downloads;
      }
      if (isYT(downloadUrl)) {
        // extract the youtube stream url
        filePath = "$savePath/${getYoutubeId(downloadUrl)}.mp4";
        StreamManifest manifest = await yt.videos.streamsClient
            .getManifest(getYoutubeId(downloadUrl));
        downloadUrl = manifest.muxed.withHighestBitrate().url.toString();
      }
      Dio dio = Dio();
      dio.download(downloadUrl, filePath, onReceiveProgress: (rcv, total) {
        for (var i = 0; i < _downloads.length; i++) {
          if (downloads[i].movie.id == movie.id) {
            _downloads[i].progress = ((rcv / total) * 100);
            downloads = _downloads;
            break;
          }
        }
      }, deleteOnError: true).then((_) async {
        for (var i = 0; i < _downloads.length; i++) {
          if (downloads[i].movie.id == movie.id) {
            _downloads[i].progress = 100;
            _downloads[i].status = DownloadStatus.Downloaded;
            downloads = _downloads;
            break;
          }
        }
        await saveReference(dl);
      }).catchError((err) {
        for (var i = 0; i < _downloads.length; i++) {
          if (downloads[i].movie.id == movie.id) {
            _downloads[i].progress = 0.0;
            _downloads[i].status = DownloadStatus.Failed;
            downloads = _downloads;
            break;
          }
        }
      });
    }
  }

  // check if file exists
  Future<bool> hasDownloaded(Movie movie, {bool isYT = false}) async {
    File file = File(await getDownloadedPath(
        isYT ? getYoutubeId(movie.downloadUrl) : movie.downloadUrl,
        isYT: isYT));
    if (file.existsSync()) return true;
    return false;
  }

  // delete download
  Future<void> delete(Download download, {bool isYT = false}) async {
    File toDelete = File(await getDownloadedPath(
        isYT
            ? getYoutubeId(download.movie.downloadUrl)
            : download.movie.downloadUrl,
        isYT: isYT));
    // delete the file if it exists
    if (toDelete.existsSync()) await toDelete.delete();
    // remove download reference
    await removeReference(download);
  }

  Future<Directory> getDownloadDir() async {
    var directory = await getApplicationDocumentsDirectory();
    var downloadDir = Directory("${directory.path}/downloads");
    // create the download directory if it does not exist
    if (!downloadDir.existsSync()) await downloadDir.create();
    return downloadDir;
  }

  Future<void> saveReference(Download download) async {
    if (await storage.ready) {
      List<dynamic> dl = storage.getItem('downloads');
      if (dl != null) {
        dl.add(download.toMap());
        await storage.setItem('downloads', dl);
      } else {
        await storage.setItem('downloads', [download.toMap()]);
      }
    }
  }

  Future<void> removeReference(Download download) async {
    if (await storage.ready) {
      List<dynamic> dl = storage.getItem('downloads');
      if (dl != null) {
        List<Download> temp = [];
        dl.forEach((d) {
          temp.add(new Download.fromMap(d));
        });
        for (var i = 0; i < temp.length; i++) {
          if (temp[i].movie.id == download.movie.id) {
            temp.removeAt(i);
            dl.removeAt(i);
            downloads = temp;
            break;
          }
        }
        await storage.setItem('downloads', dl);
      }
    }
  }
}

Future<String> getDownloadedPath(String url, {bool isYT = false}) async {
  var downloadDir = await new DownloadBloc().getDownloadDir();
  if (isYT) return "${downloadDir.path}/$url.mp4";
  return "${downloadDir.path}/${getFileNameFromUrl(url)}.${getFileExtFromUrl(url)}";
}
