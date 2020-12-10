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
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class BillTypeModel extends ChangeNotifier {
  List<BillType> _billTypeList = [];
  BillType _selectBillType;

  BillType get selectBillType => _selectBillType;

  List<BillType> get billTypeList => _billTypeList;

  void add(BillType billType) {
    _billTypeList.add(billType);
    notifyListeners();
  }

  void remove(BillType billType) {
    _billTypeList.remove(billType);
    notifyListeners();
  }

  void update(int id, BillType billType) {
    int index = _billTypeList.indexWhere((element) => element.id == id);
    if (index > -1) {
      _billTypeList.replaceRange(index, index + 1, [billType]);
      notifyListeners();
    }
  }

  void select(int index) {
    _selectBillType = _billTypeList.elementAt(index);
    notifyListeners();
  }

  void set(List<BillType> billTypeList) {
    _billTypeList = billTypeList;
    notifyListeners();
  }
}
