import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RaisedButton(
          child: Text("进入登录页面"),
          onPressed: () {
            Navigator.pushReplacementNamed(context, "/login");
          },
        ),
      ),
    );
  }
}
