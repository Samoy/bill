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

/// data : [{"id":1,"created_at":"0001-01-01T00:00:00Z","updated_at":"0001-01-01T00:00:00Z","name":"餐饮美食","image":"/images/food.png","owner":0},{"id":2,"created_at":"0001-01-01T00:00:00Z","updated_at":"0001-01-01T00:00:00Z","name":"休闲娱乐","image":"/images/amusement.png","owner":0},{"id":3,"created_at":"0001-01-01T00:00:00Z","updated_at":"0001-01-01T00:00:00Z","name":"服饰美容","image":"/images/clothes.png","owner":0},{"id":4,"created_at":"0001-01-01T00:00:00Z","updated_at":"0001-01-01T00:00:00Z","name":"交通出行","image":"/images/traffic.png","owner":0},{"id":5,"created_at":"0001-01-01T00:00:00Z","updated_at":"0001-01-01T00:00:00Z","name":"生活缴费","image":"/images/charge.png","owner":0},{"id":6,"created_at":"0001-01-01T00:00:00Z","updated_at":"0001-01-01T00:00:00Z","name":"电话充值","image":"/images/call.png","owner":0},{"id":7,"created_at":"0001-01-01T00:00:00Z","updated_at":"0001-01-01T00:00:00Z","name":"家常日用","image":"/images/daily_use.png","owner":0},{"id":8,"created_at":"0001-01-01T00:00:00Z","updated_at":"0001-01-01T00:00:00Z","name":"医疗健康","image":"/images/health.png","owner":0},{"id":9,"created_at":"0001-01-01T00:00:00Z","updated_at":"0001-01-01T00:00:00Z","name":"爱车养车","image":"/images/car.png","owner":0},{"id":10,"created_at":"0001-01-01T00:00:00Z","updated_at":"0001-01-01T00:00:00Z","name":"运动户外","image":"/images/sports.png","owner":0},{"id":11,"created_at":"0001-01-01T00:00:00Z","updated_at":"0001-01-01T00:00:00Z","name":"其他消费","image":"/images/others.png","owner":0}]
/// message : "获取账单类型列表成功"

class BillTypeListBean {
  List<BillType> _data;
  String _message;

  List<BillType> get data => _data;
  String get message => _message;

  BillTypeListBean({
      List<BillType> data, 
      String message}){
    _data = data;
    _message = message;
}

  BillTypeListBean.fromJson(dynamic json) {
    if (json["data"] != null) {
      _data = [];
      json["data"].forEach((v) {
        _data.add(BillType.fromJson(v));
      });
    }
    _message = json["message"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_data != null) {
      map["data"] = _data.map((v) => v.toJson()).toList();
    }
    map["message"] = _message;
    return map;
  }

}

/// id : 1
/// created_at : "0001-01-01T00:00:00Z"
/// updated_at : "0001-01-01T00:00:00Z"
/// name : "餐饮美食"
/// image : "/images/food.png"
/// owner : 0

class BillType {
  int _id;
  String _createdAt;
  String _updatedAt;
  String _name;
  String _image;
  int _owner;

  int get id => _id;
  String get createdAt => _createdAt;
  String get updatedAt => _updatedAt;
  String get name => _name;
  String get image => _image;
  int get owner => _owner;

  BillType({
      int id, 
      String createdAt, 
      String updatedAt, 
      String name, 
      String image, 
      int owner}){
    _id = id;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _name = name;
    _image = image;
    _owner = owner;
}

  BillType.fromJson(dynamic json) {
    _id = json["id"];
    _createdAt = json["created_at"];
    _updatedAt = json["updated_at"];
    _name = json["name"];
    _image = json["image"];
    _owner = json["owner"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["created_at"] = _createdAt;
    map["updated_at"] = _updatedAt;
    map["name"] = _name;
    map["image"] = _image;
    map["owner"] = _owner;
    return map;
  }

}