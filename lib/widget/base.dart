import 'package:flutter/material.dart';

class BaseWidget<T> extends StatelessWidget {
  const BaseWidget({Key key, this.title, this.body}) : super(key: key);

  final String title;
  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          title,
          style: TextStyle(fontFamily: "NotoSC-Black"),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: body,
      ),
    );
  }
}
