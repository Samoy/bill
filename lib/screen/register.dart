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
import 'package:bill/common/net_manager.dart';
import 'package:bill/model/bean/register_bean.dart';
import 'package:bill/model/user_model.dart';
import 'package:bill/widget/base.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

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
  final _textFieldBoxConstraints = BoxConstraints(minWidth: 32, maxHeight: 0);
  final double _iconSize = 16;
  final EdgeInsets _contentPadding = EdgeInsets.only(bottom: 0);
  final double _dividerHeight = 16;

  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      title: "注册账号",
      body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.person_sharp,
                        size: _iconSize,
                      ),
                      prefixIconConstraints: _textFieldBoxConstraints,
                      contentPadding: _contentPadding,
                      labelText: "用户名",
                      alignLabelWithHint: true),
                  onChanged: (value) {
                    _username = value;
                  },
                  validator: (value) {
                    if (value.length < 6 ||
                        value.length > 16 ||
                        !new RegExp(r"^[\dA-Za-z]{6,16}$").hasMatch(value)) {
                      return "用户名应为字母和数字，且长度在6~16位之间";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  width: double.infinity,
                  height: _dividerHeight,
                ),
                TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(
                      contentPadding: _contentPadding,
                      prefixIcon: Icon(
                        Icons.lock_sharp,
                        size: _iconSize,
                      ),
                      prefixIconConstraints: _textFieldBoxConstraints,
                      labelText: "密码",
                      alignLabelWithHint: true),
                  onChanged: (value) {
                    _password = value;
                  },
                  validator: (value) {
                    if (value.length < 6 || value.length > 16) {
                      return "密码长度应为6~16位";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  width: double.infinity,
                  height: _dividerHeight,
                ),
                TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(
                      contentPadding: _contentPadding,
                      prefixIcon: Icon(
                        Icons.lock_outline_sharp,
                        size: _iconSize,
                      ),
                      prefixIconConstraints: _textFieldBoxConstraints,
                      labelText: "确认密码",
                      alignLabelWithHint: true),
                  onChanged: (value) {
                    _confirmPassword = value;
                  },
                  validator: (value) {
                    if (value.length < 6 || value.length > 16) {
                      return "密码长度应为6~16位";
                    }
                    if (_confirmPassword != _password) {
                      return "两次密码输入不一致";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  width: double.infinity,
                  height: _dividerHeight,
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
                      contentPadding: _contentPadding,
                      prefixIcon: Icon(
                        Icons.phone_android,
                        size: _iconSize,
                      ),
                      prefixIconConstraints: _textFieldBoxConstraints,
                      labelText: "手机号",
                      alignLabelWithHint: true),
                  onChanged: (value) {
                    _telephone = value;
                  },
                ),
                SizedBox(
                  width: double.infinity,
                  height: _dividerHeight,
                ),
                TextFormField(
                  decoration: InputDecoration(
                      contentPadding: _contentPadding,
                      prefixIcon: Icon(
                        Icons.person_outline_sharp,
                        size: _iconSize,
                      ),
                      prefixIconConstraints: _textFieldBoxConstraints,
                      labelText: "昵称",
                      alignLabelWithHint: true),
                  onChanged: (value) {
                    _nickname = value;
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
                      textColor: Colors.white,
                    )),
              ],
            ),
          )),
    );
  }

  void register() async {
    try {
      EasyLoading.show(status: "请稍候...");
      Map<String, dynamic> res =
          await NetManager.getInstance().post("/api/v1/user/register", data: {
        "username": _username,
        "password": _password,
        "nickname": _nickname,
        "telephone": _telephone,
      });
      RegisterBean registerBean = RegisterBean.fromJson(res);
      if (registerBean.data != null) {
        Provider.of<UserModel>(context, listen: false).setUser(
            username: _username,
            password: _password,
            nickname: _nickname,
            telephone: _telephone);
      }
      Toast.show("注册成功", context, gravity: Toast.CENTER);
      Navigator.pop(context);
    } on DioError catch (e) {
      Toast.show(e.message, context, gravity: Toast.CENTER);
    } finally {
      EasyLoading.dismiss();
    }
  }
}
