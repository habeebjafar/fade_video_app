import 'package:fade_video_app/models/movie.dart';

enum DownloadStatus { Downloaded, Downloading, Queued, Failed }

class Download {
  Movie movie;
  double progress;
  DownloadStatus status;
  Download({this.movie, this.status, this.progress = 0.0});
}
