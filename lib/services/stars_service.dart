import 'package:fade_video_app/repository/repository.dart';

class StarsService {

  Repository _repository;

  StarsService(){
    _repository = Repository();
  }

  getAllStars() async{
    return await _repository.httpGet("stars");
  }
}