import 'package:fade_video_app/models/movie.dart';

enum DownloadStatus { Downloaded, Downloading, Queued, Failed }

class Download {
  Movie movie;
  double progress;
  DownloadStatus status;
  String timestamp;
  Download({this.movie, this.status, this.timestamp, this.progress = 0.0});

  Download.fromMap(Map<String, dynamic> map,
      {DownloadStatus downloadStatus = DownloadStatus.Downloaded})
      : timestamp = map['timestamp'],
        movie = Movie.fromMap(map['movie']),
        status = downloadStatus;

  Map<String, dynamic> toMap() {
    return {"timestamp": timestamp, 'movie': movie.toMap()};
  }
}
