import 'package:flutter/material.dart';

class CustomToast {
  static void showToast(BuildContext context, String message, int v) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: Text(message, textAlign: TextAlign.center),
        duration: Duration(seconds: 2),
        backgroundColor: v == 1 ? Colors.green : Colors.red,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10)),
        ),
      ),
    );
  }
}
