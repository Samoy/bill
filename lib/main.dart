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
import 'dart:io';

import 'package:bill/model/bill_type_model.dart';
import 'package:bill/model/token_model.dart';
import 'package:bill/model/user_model.dart';
import 'package:bill/screen/bill_add.dart';
import 'package:bill/screen/bill_type_list.dart';
import 'package:bill/screen/budget_add.dart';
import 'package:bill/screen/index.dart';
import 'package:bill/screen/login.dart';
import 'package:bill/screen/register.dart';
import 'package:bill/screen/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

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
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => TokenModel()),
          ChangeNotifierProvider(
            create: (_) => UserModel(),
          ),
          ChangeNotifierProvider(
            create: (_) => BillTypeModel(),
          )
        ],
        child: MaterialApp(
          title: '小小记账本',
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: [
            const Locale('zh', 'CH'),
            const Locale('en', 'US'),
          ],
          locale: Locale('zh'),
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
          builder: EasyLoading.init(),
          routes: {
            "/": (_) => SplashPage(),
            "/login": (_) => LoginPage(),
            "/register": (_) => RegisterPage(),
            "/index": (_) => IndexPage(),
            "/bill_add": (_) => BillAddPage(),
            "/budget_add": (_) => BudgetAddPage(),
            "/bill_type_list": (_) => BillTypeListPage()
          },
        ));
  }
}
