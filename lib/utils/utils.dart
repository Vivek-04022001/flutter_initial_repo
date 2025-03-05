import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Utilits {
  // static void log(Object? o) {
  //   assert(() {
  //     if (kDebugMode) {
  //       print(o);
  //     }

  //     return true;
  //   }());
  // }

  // static Future<bool> hasNetwork() async {
  //   try {
  //     final result = await InternetAddress.lookup('example.com');
  //     return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
  //   } catch (_) {
  //     return false;
  //   }
  // }

  static void showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.SNACKBAR,
      backgroundColor: Colors.black54,
      textColor: Colors.white,
      fontSize: 14.0,
    );
  }
}
