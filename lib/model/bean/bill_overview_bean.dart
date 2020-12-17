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

/// data : {"annual_amount":243.48,"month_amount":243.48,"today_amount":0,"week_amount":0}
/// message : "查询账单概览成功"

class BillOverviewBean {
  AmountOverview _data;
  String _message;

  AmountOverview get data => _data;

  String get message => _message;

  BillOverviewBean({AmountOverview data, String message}) {
    _data = data;
    _message = message;
  }

  BillOverviewBean.fromJson(dynamic json) {
    _data = json["data"] != null ? AmountOverview.fromJson(json["data"]) : null;
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

/// annual_amount : 243.48
/// month_amount : 243.48
/// today_amount : 0
/// week_amount : 0

class AmountOverview {
  String _annualAmount;
  String _monthAmount;
  String _todayAmount;
  String _weekAmount;

  String get annualAmount => _annualAmount;

  String get monthAmount => _monthAmount;

  String get todayAmount => _todayAmount;

  String get weekAmount => _weekAmount;

  AmountOverview(
      {String annualAmount,
      String monthAmount,
      String todayAmount,
      String weekAmount}) {
    _annualAmount = annualAmount;
    _monthAmount = monthAmount;
    _todayAmount = todayAmount;
    _weekAmount = weekAmount;
  }

  AmountOverview.fromJson(dynamic json) {
    _annualAmount = json["annual_amount"];
    _monthAmount = json["month_amount"];
    _todayAmount = json["today_amount"];
    _weekAmount = json["week_amount"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["annual_amount"] = _annualAmount;
    map["month_amount"] = _monthAmount;
    map["today_amount"] = _todayAmount;
    map["week_amount"] = _weekAmount;
    return map;
  }
}
