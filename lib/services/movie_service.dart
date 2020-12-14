import 'package:fade_video_app/repository/repository.dart';

class MovieService {
  Repository _repository;

  MovieService() {
    _repository = Repository();
  }
  // Map<String, dynamic> mockMovies = {
  //   "data": [
  //     {
  //       "id": 2,
  //       "title": "Hello World 2",
  //       "download_url":
  //           "http://mirrors.standaloneinstaller.com/video-sample/grb_2.mp4",
  //       "movie_url":
  //           "http://mirrors.standaloneinstaller.com/video-sample/grb_2.mp4",
  //       "movie_thumbnail": "https://via.placeholder.com/150/0000FF/808080",
  //       "release_date": "2020",
  //       "movie_quality_id": "123",
  //       "genres": "Action, Comedy",
  //       "movie_poster": "https://via.placeholder.com/150/0000FF/808080",
  //       "directors": "me",
  //       "crew": "Me and 25 others",
  //       "description": "Small video sample"
  //     },
  //     {
  //       "id": 3,
  //       "title": "BigBuckBunny",
  //       "download_url":
  //           "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4",
  //       "movie_url":
  //           "http://mirrors.standaloneinstaller.com/video-sample/small.mp4",
  //       "movie_thumbnail": "https://via.placeholder.com/150/0000FF/808080",
  //       "release_date": "2020",
  //       "movie_quality_id": "123",
  //       "genres": "Action, Comedy",
  //       "movie_poster": "https://via.placeholder.com/150/0000FF/808080",
  //       "directors": "me",
  //       "crew": "Me and 25 others",
  //       "description": "Small video sample"
  //     },
  //     {
  //       "id": 4,
  //       "title": "Youtube Video",
  //       "download_url": "https://www.youtube.com/watch?v=G4JuopziR3Q",
  //       "movie_url": "https://www.youtube.com/watch?v=G4JuopziR3Q",
  //       "movie_thumbnail": "https://via.placeholder.com/150/0000FF/808080",
  //       "release_date": "2020",
  //       "movie_quality_id": "123",
  //       "genres": "Action, Comedy",
  //       "movie_poster": "https://via.placeholder.com/150/0000FF/808080",
  //       "directors": "me",
  //       "crew": "Me and 25 others",
  //       "description": "Small video sample"
  //     }
  //   ]
  // };

  getDramaMovies() {
    // return mockMovies;
    return _repository.httpGet("get-all-dramas");
  }

  getThrillerMovies() {
    return _repository.httpGet("get-all-thrillers");
  }

  getLatestMovies() {
    return _repository.httpGet("get-all-latest-movies");
  }

  getAnimationMovies() {
    return _repository.httpGet("get-all-animation");
  }

  getMoviesByGenreName(genreName) async {
    return await _repository.httpGetByName(
        "get-movies-by-genre-name", genreName);
  }

  getAllSeries() async {
    return await _repository.httpGet("get-all-series");
  }

  getSeasonsBySeriesId(seriesId) async {
    return await _repository.httpGetById("get-seasons-by-seriesId", seriesId);
  }

  getEpisodesBySeasonsId(seriesId, seasonId) async {
    return await _repository.httpGetByTwoId(
        "get-episodes-by-seasonId", seriesId, seasonId);
  }
}
