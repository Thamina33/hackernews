import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:http/http.dart' as http;
import '../services/remote_services.dart';
import '../utility/api_const.dart';

class TopStoryRepo extends GetxController implements GetxService {
  RemoteServices remoteServices;

  TopStoryRepo({required this.remoteServices});

  Future<http.Response> fetchTopNewsList() async {
    var response = await remoteServices.getRequest(ApiConstants.topstories);
    return response;
  }

  Future<http.Response> fetchASingleStory(int id) async {
    var response = await remoteServices.getRequest('/item/$id.json');
    return response;
  }
}
