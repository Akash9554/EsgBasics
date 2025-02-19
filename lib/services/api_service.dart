import 'dart:convert';
import 'package:http/http.dart' as http;

import '../Model/SettingResponce.dart';
import '../Widget/api.dart';



class ApiService {
  static var client = http.Client();
  static Future<SettingResponce> fetchRouteData(String userid) async {
    var headers = {'Content-Type': 'application/json'};
      var url =
      Uri.parse(ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.setting);
      Map body = {
        'user_id': userid
      };
      http.Response response =
      await http.post(url, body: jsonEncode(body), headers: headers);
      if (response.statusCode == 200) {
        return routeModelFromJson(response.body);
      } else {
        throw Exception('Failed to load album');
      }
  }
  
}
