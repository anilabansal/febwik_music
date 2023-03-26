import 'dart:developer';

import 'package:get/get.dart';
import 'package:music_app/app/services/api.dart';

class ApiClient extends GetConnect {
  Future<Response> getRequest(String uri) async {
    try {
      Response response = await get("${Api.baseUrl}$uri");
      log(response.statusText.toString());
      return response;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> postRequest(String uri, body) async {
    try {
      Response response = await post("${Api.baseUrl}$uri", body);
      log(response.statusText.toString());
      return response;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }
}
