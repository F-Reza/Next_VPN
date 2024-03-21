import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyDialogs {
  static success({required String msg}) {
    Get.snackbar('Success', msg,
        snackPosition: SnackPosition.BOTTOM,
        colorText: Colors.white, backgroundColor: Colors.green.withOpacity(.9));
  }

  static error({required String msg}) {
    Get.snackbar('Error', msg,
        snackPosition: SnackPosition.BOTTOM,
        colorText: Colors.white,
        backgroundColor: Colors.redAccent.withOpacity(.9));
  }

  static info({required String msg}) {
    Get.snackbar('Info',
        backgroundColor: Colors.blue,
        snackPosition: SnackPosition.BOTTOM,
        msg, colorText: Colors.white);
  }

  static showProgress() {
    Get.dialog(Center(child: CircularProgressIndicator(strokeWidth: 2)));
  }
}
