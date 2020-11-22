import 'dart:io';

import 'package:bill/screen/home.dart';
import 'package:bill/screen/login.dart';
import 'package:bill/screen/register.dart';
import 'package:bill/screen/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
  if (Platform.isAndroid) {
    SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, //设置为透明
    );
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.amber,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          inputDecorationTheme: InputDecorationTheme(
              labelStyle: TextStyle(fontSize: 14),
              contentPadding: EdgeInsets.symmetric(vertical: 16),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.amber),
              ))),
      initialRoute: "/",
      routes: {
        "/": (_) => SplashPage(),
        "/login": (_) => LoginPage(),
        "/home": (_) => HomePage(),
        "/register": (_) => RegisterPage()
      },
    );
  }
}
