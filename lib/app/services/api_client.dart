import 'dart:developer';
import 'package:get/get.dart';
import 'package:music_app/app/services/api.dart';

class ApiClient extends GetConnect {
  Future<dynamic> getRequest(String uri) async {
    try {
      Response response = await get("${Api.baseUrl}$uri");

      print('URL Request ------------------------------->\n ${Api.baseUrl}$uri');
      log(response.statusText.toString());

      return response;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<dynamic> postRequest(String uri, body) async {
    try {
      Response response = await post("${Api.baseUrl}$uri", body);
      print('URL Request ------------------------------->\n ${Api.baseUrl}$uri');
      print('body Request ------------------------------->\n $body');
      log(response.statusText.toString());
      return response;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }
}
