import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;


class Repository{
  //String _baseUrl = 'https://www.ecom-api.royalclassic.com.ng/api';
  String _baseUrl = 'http://192.168.43.95:9000/api';

    httpGet(String api) async{
      var dio = await Dio().get(_baseUrl + "/" + api);
      return dio.data;
     //return await http.get(_baseUrl + "/" + api);
    }


  httpGetById(String api, subjectId) async {
    var dio =  await Dio().get(_baseUrl + "/" + api + "/" + subjectId.toString());
    return dio.data;
  }

  httpGetByTwoId(String api, seriesId,seasonId) async {
    var dio =  await Dio().get(_baseUrl + "/" + api + "/" + seriesId.toString() +"," +seasonId.toString());
    return dio.data;
  }


  httpGetByName(String api, name) async {
    var dio =  await Dio().get(_baseUrl + "/" + api + "/" + name.toString());
    return dio.data;
  }

}