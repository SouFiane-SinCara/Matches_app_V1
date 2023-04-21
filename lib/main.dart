import 'package:flutter/material.dart';
import 'package:match_app_v1/UI/config/colors.dart';
import 'package:match_app_v1/app.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(primaryColor : prime),
    debugShowCheckedModeBanner: false,
    home: const App(),
  ));
}