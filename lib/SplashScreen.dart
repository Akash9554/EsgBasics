import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import 'Hometab.dart';
import 'LoginPage.dart';
import 'package:esgbasics/services/tab/GarmentMAnufascturer/Textiletab2.dart';
import 'package:esgbasics/services/tab/GinnerTab/Ginnertab.dart';
import 'package:esgbasics/services/tab/Spinnertab/Spinnertab.dart';
import 'package:esgbasics/services/tab/Textiletab/Textiletab.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final getstorage = GetStorage();

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), _navigateToNextScreen);
  }

  void _navigateToNextScreen() {
    final userId = getstorage.read("id");
    final userType = getstorage.read("user_type");

    if (userId == null) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const SignUpPage()));
      return;
    }

    Widget nextScreen;
    switch (userType) {
      case 1:
        nextScreen = HomeTab();
        break;
      case 2:
        nextScreen = GinnerTab();
        break;
      case 3:
        nextScreen = Spinnertab();
        break;
      case 4:
        nextScreen = Textiletab();
        break;
      case 5:
        nextScreen = Textiletab2();
        break;
      default:
        nextScreen = HomeTab(); // Fallback to HomeTab if `user_type` is unknown
    }

    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => nextScreen));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.center,
            colors: [
              Color(0xFF6EDB7B), // Green// Light green
              Color(0xFFCBFF6B), // Yellow-green
            ],
          ),
        ),
        child: Center(
          child: Image.asset(
            'assets/images/splogo.png',
            width: 250,
            height: 250,
          ),
        ),
      ),
    );
  }
}
