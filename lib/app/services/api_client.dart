import 'dart:developer';
import 'package:get/get.dart';
import 'package:music_app/app/services/api.dart';
import 'package:music_app/dataBase/app_data_base.dart';

class ApiClient extends GetConnect {
  Future<dynamic> getRequest(String uri) async {
    try {
      var headers = {
        "Authorization": "Bearer ${AppLocalStorage().authToken}"
      };
      Response response = await get("${Api.baseUrl}$uri",headers: headers);
      print('headers ------------------------------->\n $headers');
      print(
          'URL Request ------------------------------->\n ${Api.baseUrl}$uri');

      log(response.statusText.toString());

      return response;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<dynamic> postRequest(String uri, body) async {
    try {
      var headers = {
        "Accept": "application/json",
        "Authorization": "Bearer ${AppLocalStorage().authToken}"
      };

      Response response =
          await post("${Api.baseUrl}$uri", body,headers: headers );
      print(
          'URL Request ------------------------------->\n ${Api.baseUrl}$uri');
      print('body Request ------------------------------->\n $body');
      print('headers ------------------------------->\n $headers');
      log(response.statusText.toString());
      return response;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }
}
