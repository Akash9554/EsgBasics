import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../services/tab/GarmentMAnufascturer/Textiletab2.dart';
import '../services/tab/GinnerTab/Ginnertab.dart';
import '../services/tab/Spinnertab/Spinnertab.dart';
import '../services/tab/Textiletab/Textiletab.dart';
import '../services/tab/farmertab/Hometab.dart';
import '../Model/LoginResponce.dart';
import '../Widget/api.dart';

class LoginController extends GetxController {
   
  String email = "";
  String password = "";


 static login(BuildContext context,String email, String password) {
   email = email;
      password = password;
      EasyLoading.show(status: 'loading...');
      loginWithEmail(email, password,context);
  }

  static Future<void> loginWithEmail(email, password ,context) async {
    EasyLoading.show(status: 'loading...');
    var headers = {'Content-Type': 'application/json'};
    try {
      var url =
          Uri.parse(ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.login);
      Map body = {
        'email': email.trim(),
        'password': password,
      };
      http.Response response = await http.post(url, body: jsonEncode(body), headers: headers);

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        if (json['errorCode'] == "0") {
          EasyLoading.dismiss();
          final getStorge = GetStorage();
          LoginResponce loginModel = LoginResponce.fromJson(json);
          int? id = loginModel.data![0].id;

          String? firstName = loginModel.data![0].name;
          String? mobileNo = loginModel.data![0].mobileNo;
          String? email = loginModel.data![0].email;
          int? userType=loginModel.data![0].userType;
          String? profile_qr_code=loginModel.data![0].profile_qr_code;
          EasyLoading.showSuccess('Login Successfully !');

            getStorge.write("id",id);
            getStorge.write("suc","suc");
            getStorge.write("name", firstName);
            getStorge.write("mobileno", mobileNo);
            getStorge.write("email", email);
            getStorge.write("user_type",userType);
          getStorge.write('profile_qr_code', profile_qr_code);
            if(userType==1){

          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>  HomeTab()));
              }else if(userType==2){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>  GinnerTab()));
            }else if(userType==3){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>  Spinnertab()));
            }else if(userType==4){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>  Textiletab()));
            }else if(userType==5){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>  Textiletab2()));
            }

        } else if (json['errorCode'] == "1") {
          EasyLoading.dismiss();
          EasyLoading.showError(json['errorMsg']);
        }
      } else {
        EasyLoading.dismiss();
        EasyLoading.showError('Failed Something is Wrong !');
      }
    } catch (error) {
      EasyLoading.dismiss();
      EasyLoading.showError('Failed Something is Wrong !');
    }
  }
}



