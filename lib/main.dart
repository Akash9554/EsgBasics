import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'SplashScreen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
   FlutterDownloader.initialize(
      debug: true // optional: set false to disable printing logs to console
  );
  runApp(MaterialApp(
    home: const SplashScreen(),
    builder: EasyLoading.init(),
    debugShowCheckedModeBanner: false,// SplashScreen is the initial route
  ));
}