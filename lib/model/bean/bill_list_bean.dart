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

import 'bill_type_list_bean.dart';

/// data : [{"id":1,"created_at":"2020-12-08T16:39:43+08:00","updated_at":"2020-12-08T16:39:43+08:00","name":"吃饭","amount":"20.88","billType":{"id":1,"created_at":"2020-12-08T16:39:35+08:00","updated_at":"2020-12-08T16:39:35+08:00","name":"餐饮美食","image":"/images/1607416775.png","owner":1},"date":"2020-12-08T08:00:00+08:00","remark":"午饭","user_id":1,"income":false}]
/// message : "查询账单列表成功"

class BillListBean {
  List<Bill> _data;
  String _message;

  List<Bill> get data => _data;
  String get message => _message;

  BillListBean({
      List<Bill> data, 
      String message}){
    _data = data;
    _message = message;
}

  BillListBean.fromJson(dynamic json) {
    if (json["data"] != null) {
      _data = [];
      json["data"].forEach((v) {
        _data.add(Bill.fromJson(v));
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
/// created_at : "2020-12-08T16:39:43+08:00"
/// updated_at : "2020-12-08T16:39:43+08:00"
/// name : "吃饭"
/// amount : "20.88"
/// billType : {"id":1,"created_at":"2020-12-08T16:39:35+08:00","updated_at":"2020-12-08T16:39:35+08:00","name":"餐饮美食","image":"/images/1607416775.png","owner":1}
/// date : "2020-12-08T08:00:00+08:00"
/// remark : "午饭"
/// user_id : 1
/// income : false

class Bill {
  int _id;
  String _createdAt;
  String _updatedAt;
  String _name;
  String _amount;
  BillType _billType;
  String _date;
  String _remark;
  int _userId;
  bool _income;

  int get id => _id;
  String get createdAt => _createdAt;
  String get updatedAt => _updatedAt;
  String get name => _name;
  String get amount => _amount;
  BillType get billType => _billType;
  String get date => _date;
  String get remark => _remark;
  int get userId => _userId;
  bool get income => _income;

  Bill({
      int id, 
      String createdAt, 
      String updatedAt, 
      String name, 
      String amount, 
      BillType billType, 
      String date, 
      String remark, 
      int userId, 
      bool income}){
    _id = id;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _name = name;
    _amount = amount;
    _billType = billType;
    _date = date;
    _remark = remark;
    _userId = userId;
    _income = income;
}

  Bill.fromJson(dynamic json) {
    _id = json["id"];
    _createdAt = json["created_at"];
    _updatedAt = json["updated_at"];
    _name = json["name"];
    _amount = json["amount"];
    _billType = json["billType"] != null ? BillType.fromJson(json["billType"]) : null;
    _date = json["date"];
    _remark = json["remark"];
    _userId = json["user_id"];
    _income = json["income"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["created_at"] = _createdAt;
    map["updated_at"] = _updatedAt;
    map["name"] = _name;
    map["amount"] = _amount;
    if (_billType != null) {
      map["billType"] = _billType.toJson();
    }
    map["date"] = _date;
    map["remark"] = _remark;
    map["user_id"] = _userId;
    map["income"] = _income;
    return map;
  }

}
