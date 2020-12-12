import 'package:fade_video_app/repository/repository.dart';

class MovieService{
  Repository _repository;

  MovieService(){
    _repository = Repository();
  }

  getDramaMovies(){
    return _repository.httpGet("get-all-dramas");
  }

  getThrillerMovies(){
    return _repository.httpGet("get-all-thrillers");
  }

  getLatestMovies(){
    return _repository.httpGet("get-all-latest-movies");
  }

  getAnimationMovies(){
    return _repository.httpGet("get-all-animation");
  }

  getMoviesByGenreName(genreName) async{
    return await _repository.httpGetByName("get-movies-by-genre-name",genreName);
  }

  getAllSeries() async{
    return await _repository.httpGet("get-all-series");
  }

  getSeasonsBySeriesId(seriesId) async{

    return await _repository.httpGetById("get-seasons-by-seriesId", seriesId);
  }

  getEpisodesBySeasonsId(seriesId,seasonId) async{

    return await _repository.httpGetByTwoId("get-episodes-by-seasonId",seriesId,seasonId);
  }

}