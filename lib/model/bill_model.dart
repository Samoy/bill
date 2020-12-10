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

import 'package:bill/model/bean/bill_list_bean.dart';
import 'package:flutter/foundation.dart';

class BillModel extends ChangeNotifier {
  List<Bill> _recentBillList = [];

  List<Bill> _dailyBillList = [];
  List<Bill> _weeklyBillList = [];
  List<Bill> _monthlyBillList = [];
  List<Bill> _annualBillList = [];
  double _dailyAmount = 0;
  double _weeklyAmount = 0;
  double _monthlyAmount = 0;
  double _annualAmount = 0;

  List<Bill> get recentBillList => _recentBillList;

  List<Bill> get dailyBillList => _dailyBillList;

  List<Bill> get weeklyBillList => _weeklyBillList;

  List<Bill> get monthlyBillList => _monthlyBillList;

  List<Bill> get annualBillList => _annualBillList;

  //fixme:计算金额最好放在服务端来做，以免数据量过大时资源消耗过多
  double get dailyAmount => _dailyAmount;

  double get weeklyAmount => _weeklyAmount;

  double get monthlyAmount => _monthlyAmount;

  double get annualAmount => _annualAmount;

  set recentBillList(List<Bill> value) {
    _recentBillList = value;
    notifyListeners();
  }

  set dailyBillList(List<Bill> value) {
    _dailyBillList = value;
    List<double> amountList =
        _dailyBillList.map((e) => double.tryParse(e.amount)).toList();
    if (amountList.isNotEmpty) {
      _dailyAmount = amountList.reduce((value, element) => value + element);
    }
    notifyListeners();
  }

  set weeklyBillList(List<Bill> value) {
    _weeklyBillList = value;
    List<double> amountList =
        _weeklyBillList.map((e) => double.tryParse(e.amount)).toList();
    if (amountList.isNotEmpty) {
      _weeklyAmount = amountList.reduce((value, element) => value + element);
    }
    notifyListeners();
  }

  set monthlyBillList(List<Bill> value) {
    _monthlyBillList = value;
    List<double> amountList =
        _monthlyBillList.map((e) => double.tryParse(e.amount)).toList();
    if (amountList.isNotEmpty) {
      _monthlyAmount = amountList.reduce((value, element) => value + element);
    }
    notifyListeners();
  }

  set annualBillList(List<Bill> value) {
    _annualBillList = value;
    List<double> amountList =
        _annualBillList.map((e) => double.tryParse(e.amount)).toList();
    if (amountList.isNotEmpty) {
      _annualAmount = amountList.reduce((value, element) => value + element);
    }
    notifyListeners();
  }
}
