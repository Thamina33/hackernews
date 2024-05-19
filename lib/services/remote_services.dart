import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../utility/api_const.dart';

class RemoteServices extends GetxService {
  static var client = http.Client();

  Future<http.Response> getRequest(String path) async {
    var header = {"Content-Type": "application/json"};

    var response = await RemoteServices.client
        .get(Uri.parse("${ApiConstants.baseUrl}$path"), headers: header);

    debugPrint(response.body.toString());
    if (kDebugMode) {
      print(header.toString());
    }
    debugPrint("${ApiConstants.baseUrl}$path");
    debugPrint("status ${response.statusCode.toString()}");

    return response;
  }
}
