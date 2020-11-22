import 'package:bill/widget/base.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String _username = "";
  String _password = "";
  String _confirmPassword = "";
  String _telephone = "";
  String _nickname = "";
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      title: "注册账号",
      body: SingleChildScrollView(
          child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person_sharp),
                  prefixIconConstraints:
                      BoxConstraints(minWidth: 32, maxHeight: 8),
                  labelText: "输入您的用户名",
                  alignLabelWithHint: true),
              onChanged: (value) {
                setState(() {
                  _username = value;
                });
              },
              validator: (value) {
                if (value.length < 6 ||
                    value.length > 16 ||
                    !new RegExp(r"^[\dA-Za-z]{6,16}$").hasMatch(value)) {
                  return "用户名长度应为字母和数字，且长度在6~16位之间";
                }
                return null;
              },
            ),
            TextFormField(
              obscureText: true,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.lock_sharp),
                  prefixIconConstraints:
                      BoxConstraints(minWidth: 32, maxHeight: 8),
                  labelText: "输入您的密码",
                  alignLabelWithHint: true),
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
            TextFormField(
              obscureText: true,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.lock_outline_sharp),
                  prefixIconConstraints:
                      BoxConstraints(minWidth: 32, maxHeight: 8),
                  labelText: "再次输入您的密码",
                  alignLabelWithHint: true),
              onChanged: (value) {
                setState(() {
                  _confirmPassword = value;
                });
              },
              validator: (value) {
                if (value.length < 6 || value.length > 16) {
                  return "密码长度应为6~16位";
                }
                if (value != _password) {
                  return "两次密码输入不一致";
                }
                return null;
              },
            ),
            TextFormField(
              keyboardType: TextInputType.phone,
              validator: (value) {
                if (!new RegExp(r"^1[3456789](\d){9}$").hasMatch(value)) {
                  return "手机号格式不正确";
                }
                return null;
              },
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.phone_android),
                  prefixIconConstraints:
                      BoxConstraints(minWidth: 32, maxHeight: 8),
                  labelText: "输入您的手机号",
                  alignLabelWithHint: true),
              onChanged: (value) {
                setState(() {
                  _telephone = value;
                });
              },
            ),
            TextFormField(
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person_outline_sharp),
                  prefixIconConstraints:
                      BoxConstraints(minWidth: 32, maxHeight: 8),
                  labelText: "给自己起个昵称吧",
                  alignLabelWithHint: true),
              onChanged: (value) {
                setState(() {
                  _telephone = value;
                });
              },
              validator: (value) {
                if (value.length < 4 || value.length > 10) {
                  return "昵称长度应为4~10位";
                }
                return null;
              },
            ),
            Container(
                margin: EdgeInsets.only(top: 20),
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
                      register();
                    }
                  },
                  elevation: 0,
                  highlightElevation: 0,
                  child: Text("立即注册"),
                  minWidth: double.infinity,
                  color: Colors.amber,
                  textColor: Colors.white,
                )),
          ],
        ),
        autovalidateMode: AutovalidateMode.onUserInteraction,
      )),
    );
  }

  void register() async {}
}
