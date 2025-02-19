import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../Model/SignupResponce.dart';
import '../OtpScreen.dart';
import '../Widget/api.dart';




class SignUpControler extends GetxController {

  String name = "";
  String mobile_no = "";
  String email="";
  String password="";
  String user_type="";


  static login(BuildContext context,String name,String mobileNo,String email, String password,String userType) {
      name = name;
      mobileNo=mobileNo;
      email = email;
      password = password;
      userType=userType;
      Signup(name,mobileNo,email, password,userType,context);
  }

  static Future<void> Signup(name,mobileNo,email, password , userType ,context) async {
    EasyLoading.show(status: 'loading...');
    var headers = {'Content-Type': 'application/json'};
    try {
      var url =
      Uri.parse(ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.register);
      Map body = {
        "name":name,
        "mobile_no":mobileNo,
        'email': email.trim(),
        'password': password,
        'user_type':userType
      };
      http.Response response =
      await http.post(url, body: jsonEncode(body), headers: headers);

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        if (json['errorCode'] == "0") {
          EasyLoading.dismiss();
          final getStorge = GetStorage();
          SignupResponce loginModel = SignupResponce.fromJson(json);
          int? id = loginModel.data![0].id;
          String? firstName = loginModel.data![0].name;
          String? mobileNo = loginModel.data![0].mobileNo;
          String? email = loginModel.data![0].email;
          String? profile_qr_code=loginModel.data![0].profile_qr_code;

          EasyLoading.showSuccess('Registration Successfully Completed!');
          getStorge.write("id",id);
          getStorge.write("suc","suc");
          getStorge.write("name", firstName);
          getStorge.write("mobileno", mobileNo);
          getStorge.write("email", email);
          getStorge.write("user_type",userType);
          getStorge.write('profile_qr_code', profile_qr_code);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  OTPScreen(otp: '1234'),
            ),
          );


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



