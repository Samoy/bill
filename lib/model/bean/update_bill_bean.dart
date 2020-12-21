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

import 'package:bill/model/bean/bill_type_list_bean.dart';

import 'bill_list_bean.dart';

/// data : {"id":1,"created_at":"2020-12-08T16:39:43+08:00","updated_at":"2020-12-08T16:39:43+08:00","name":"吃饭","amount":"20.88","bill_type":{"id":1,"created_at":"2020-12-08T16:39:35+08:00","updated_at":"2020-12-08T16:39:35+08:00","name":"餐饮美食","image":"/images/1607416775.png","owner":1},"date":"2020-12-08T08:00:00+08:00","remark":"午饭","user_id":1,"income":false}
/// message : "账单更新成功"

class UpdateBillBean {
  Bill _data;
  String _message;

  Bill get data => _data;

  String get message => _message;

  UpdateBillBean({Bill data, String message}) {
    _data = data;
    _message = message;
  }

  UpdateBillBean.fromJson(dynamic json) {
    _data = json["data"] != null ? Bill.fromJson(json["data"]) : null;
    _message = json["message"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_data != null) {
      map["data"] = _data.toJson();
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
/// bill_type : {"id":1,"created_at":"2020-12-08T16:39:35+08:00","updated_at":"2020-12-08T16:39:35+08:00","name":"餐饮美食","image":"/images/1607416775.png","owner":1}
/// date : "2020-12-08T08:00:00+08:00"
/// remark : "午饭"
/// user_id : 1
/// income : false
