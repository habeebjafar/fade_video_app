import 'package:fade_video_app/repository/repository.dart';

class GenreService{
  Repository _repository;

  GenreService(){
    _repository = Repository();
  }

  getGenres() async{
    return await _repository.httpGet("genres");
  }

}