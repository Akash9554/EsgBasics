import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get_storage/get_storage.dart';
import 'LoginPage.dart';
import 'Model/SettingResponce.dart';
import 'Widget/DelayedWebView.dart';
import 'Widget/api.dart';
import 'package:http/http.dart' as http;

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final getstorage = GetStorage();
  String name = "";
  String number = "";
  int userid=0;
  String profile_qr_code="";
  late Future<SettingResponce> fetchsettingdata;



  @override
  void initState() {
    super.initState();
    name = getstorage.read("name");
    number = getstorage.read("mobileno");
    userid = getstorage.read("id");
    profile_qr_code=getstorage.read('profile_qr_code');

  }

  @override
  Widget build(BuildContext context) {
    double sheight = MediaQuery.of(context).size.height;
    double swidth = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Material(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFFFFFFFF), // Green
                Color(0xFF79DD8B), // Light green
                Color(0xFFCBFF6B), // Yellow-green
              ],
            ),
          ),
          width: swidth,
          height: sheight,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 80),
              Image.asset(
                'assets/images/splogo.png',
                // Replace with your image asset path
                height: 200,
                width: 200,
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  padding: const EdgeInsets.all(5.0),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextFormField(
                          decoration: InputDecoration(
                            hintText: name,
                            hintStyle: const TextStyle(
                                color: Colors.black,
                                fontSize: 16.0,
                                fontFamily: 'Poppins_sego'),
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  padding: const EdgeInsets.all(5.0),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextFormField(
                          decoration: InputDecoration(
                            hintText: number,
                            hintStyle: const TextStyle(
                                color: Colors.black,
                                fontSize: 16.0,
                                fontFamily: 'Poppins_sego'),
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Center(
                child: DelayedWebView(url:profile_qr_code!),
              ),
              // Add other form fields similarly
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 400.0,
                      height: 60.0,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      child: TextButton(
                        onPressed: () {
                          final getStorge = GetStorage();
                          getStorge.erase();
                          Navigator.pushReplacement(context, MaterialPageRoute(
                                  builder: (context) => const SignUpPage()));
                        },
                        child: const Text(
                          'Logout',
                          style: TextStyle(
                            fontFamily: 'Poppins_semi',
                            color: Colors.white,
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 400.0,
                      height: 60.0,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      child: TextButton(
                        onPressed: () {
                          final getStorge = GetStorage();

                          getsetting(userid.toString());

                        },
                        child: const Text(
                          'Delete Account',
                          style: TextStyle(
                            fontFamily: 'Poppins_semi',
                            color: Colors.white,
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  void getsetting(String id) async {
    EasyLoading.show(status: 'loading...');
    fetchsettingdata = ApiService.fetchRouteData('27');
      fetchsettingdata.then((response) {
          getstorage.erase();
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => const SignUpPage()));

      }).catchError((error) {
        EasyLoading.dismiss();
        print("Error fetching data: $error");
      });
  }
}
class ApiService {
  static var client = http.Client();
  static Future<SettingResponce> fetchRouteData(String userid) async {
    var headers = {'Content-Type': 'application/json'};
    var url =
    Uri.parse(ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.deleteuser);
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


