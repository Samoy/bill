import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _username = "";
  String _password = "";
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 120),
        child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(bottom: 80),
                  child: Text(
                    "小小记账本",
                    style: TextStyle(
                        color: Colors.amber,
                        fontSize: 40,
                        fontFamily: "NotoSC-Black"),
                  ),
                ),
                Divider(color: Colors.amber, thickness: 1),
                TextFormField(
                  validator: (value) {
                    if (value.length < 6 ||
                        value.length > 16 ||
                        !new RegExp(r"^[\dA-Za-z]{6,16}$").hasMatch(value)) {
                      return "用户名长度应为字母和数字，且长度在6~16位之间";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      hintText: "请输入用户名",
                      contentPadding:
                          EdgeInsets.only(left: 12, right: 12, bottom: 8)),
                  onChanged: (value) {
                    setState(() {
                      _username = value;
                    });
                  },
                ),
                TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(
                      hintText: "请输入密码",
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 16)),
                  onChanged: (value) {
                    setState(() {
                      _password = value;
                    });
                  },
                  validator: (value) {
                    if (value.length < 6 || value.length > 16) {
                      return "密码长度应为6~16位";
                    }
                    return null;
                  },
                ),
                Container(
                    margin: EdgeInsets.only(top: 20, bottom: 8),
                    padding: EdgeInsets.zero,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(3)),
                        gradient: LinearGradient(colors: [
                          Colors.amberAccent,
                          Colors.amber,
                          Colors.orange
                        ])),
                    child: MaterialButton(
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          login();
                        }
                      },
                      elevation: 0,
                      highlightElevation: 0,
                      child: Text(
                        "登录",
                        style: TextStyle(color: Colors.white),
                      ),
                      minWidth: double.infinity,
                      textColor: Colors.white,
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                        highlightColor: Colors.transparent,
                        splashColor: Colors.amber,
                        onTap: () {
                          Navigator.pushNamed(context, "/register");
                        },
                        child: Text(
                          "注册账号",
                        )),
                    InkWell(
                        highlightColor: Colors.transparent,
                        splashColor: Colors.amber,
                        onTap: () {},
                        child: Text(
                          "忘记密码？",
                        ))
                  ],
                )
              ],
            )),
      ),
    );
  }

  void login() async {}
}
