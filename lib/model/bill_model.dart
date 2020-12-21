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
import 'package:bill/model/bean/bill_overview_bean.dart';
import 'package:flutter/foundation.dart';

class BillModel extends ChangeNotifier {
  List<Bill> _recentBillList = [];
  AmountOverview _overview = AmountOverview(
      annualAmount: "0", monthAmount: "0", weekAmount: "0", todayAmount: "0");

  List<Bill> get recentBillList => _recentBillList;

  set recentBillList(List<Bill> value) {
    _recentBillList = value;
    notifyListeners();
  }

  AmountOverview get overview => _overview;

  set overview(AmountOverview value) {
    _overview = value;
    notifyListeners();
  }
}
