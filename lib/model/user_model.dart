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
import 'package:flutter/foundation.dart';

class UserModel extends ChangeNotifier {
  String _username = "";
  String _password = "";
  String _telephone = "";
  String _nickname = "";

  String get username => _username;

  String get password => _password;

  String get telephone => _telephone;

  String get nickname => _nickname;

  void setUser(
      {String username, String password, String telephone, String nickname}) {
    if (username != null) {
      _username = username;
    }
    if (password != null) {
      _password = password;
    }
    if (telephone != null) {
      _telephone = telephone;
    }
    if (nickname != null) {
      _nickname = nickname;
    }
    notifyListeners();
  }
}
