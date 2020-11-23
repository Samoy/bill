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

class UserBean {
  int _id;
  String _createdAt;
  String _updatedAt;
  String _username;
  String _telephone;
  String _nickname;

  int get id => _id;
  String get createdAt => _createdAt;
  String get updatedAt => _updatedAt;
  String get username => _username;
  String get telephone => _telephone;
  String get nickname => _nickname;

  UserBean({
    int id,
    String createdAt,
    String updatedAt,
    String username,
    String telephone,
    String nickname}){
    _id = id;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _username = username;
    _telephone = telephone;
    _nickname = nickname;
  }

  UserBean.fromJson(dynamic json) {
    _id = json["id"];
    _createdAt = json["created_at"];
    _updatedAt = json["updated_at"];
    _username = json["username"];
    _telephone = json["telephone"];
    _nickname = json["nickname"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["created_at"] = _createdAt;
    map["updated_at"] = _updatedAt;
    map["username"] = _username;
    map["telephone"] = _telephone;
    map["nickname"] = _nickname;
    return map;
  }

}