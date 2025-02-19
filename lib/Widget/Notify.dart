import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Notify {
  static void snackbar(String title, String msg) {
    Get.snackbar(
      title,
      msg,
      icon: Image.asset("assets/images/splogo.png"),
      backgroundColor: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      borderRadius: 10,
      borderWidth: 2,
      colorText: Colors.black,
      isDismissible: true,
      forwardAnimationCurve: Curves.easeOutBack,
    );
  }
}
