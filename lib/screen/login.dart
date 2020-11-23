/*
 * MIT License
 *
 * Copyright (c) 2020 Samoy
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */
import 'package:bill/common/constant.dart';
import 'package:bill/common/net_manager.dart';
import 'package:bill/model/bean/login_bean.dart';
import 'package:bill/model/token_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

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
                      return "用户名应为字母和数字，且长度在6~16位之间";
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

  void login() async {
    try {
      EasyLoading.show(status: '请稍候...');
      Map<String, dynamic> res = await NetManager.getInstance().post(
          "api/v1/user/login",
          data: {"username": _username, "password": _password});
      LoginBean loginBean = LoginBean.fromJson(res);
      String token = loginBean.data.token;
      if (token != null && token.isNotEmpty) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString(kStorageToken, token);
        Provider.of<TokenModel>(context, listen: false).setToken(token);
        Navigator.pushReplacementNamed(context, "/home");
      }
    } catch (DioError) {} finally {
      EasyLoading.dismiss();
    }
  }
}
