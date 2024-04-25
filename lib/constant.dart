import 'package:flutter/material.dart';

showSnakBar(context, color, message) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: const TextStyle(fontSize: 14, color: Colors.black),
      ),
      backgroundColor: color,
      duration: const Duration(seconds: 2),
      // action: SnackBarAction(
      //   label: 'Ok',
      //   onPressed: () {},
      //   textColor: Colors.white,
      // ),
    ),
  );
}

navigatTo(context, widget) => Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return widget;
        },
      ),
    );

navigatAndReplace(context, widget) => Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) {
          return widget;
        },
      ),
    );

var uId = '';
