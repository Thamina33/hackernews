import 'package:get/get.dart';
import 'package:hackernews/utility/api_const.dart';
import 'package:http/http.dart' as http;
import 'package:hackernews/services/remote_services.dart';

class LatestStoryRepo extends GetxController implements GetxService{
  RemoteServices remoteServices;
  LatestStoryRepo({required this.remoteServices});
  
  Future<http.Response> fetchLatestNewsList() async {
    var response = await remoteServices.getRequest(ApiConstants.newStories);
    return response;
  }

  Future<http.Response> fetchASingleStory(int id) async {
    var response = await remoteServices.getRequest('/item/$id.json');
    return response;
  }
}