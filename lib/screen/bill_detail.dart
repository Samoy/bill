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

import 'package:bill/common/net_manager.dart';
import 'package:bill/widget/base.dart';
import 'package:flutter/material.dart';

class BillDetail extends StatefulWidget {
  final int _id;

  @override
  _BillDetailState createState() => _BillDetailState(_id);

  BillDetail(this._id);
}

class _BillDetailState extends State<BillDetail> {
  int _id;

  @override
  void initState() {
    fetchBillDetail();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      title: "账单详情",
    );
  }

  Future fetchBillDetail() async {
    Map<String, dynamic> res =
        await NetManager.getInstance(context).get("/api/v1/bill?bill_id=$_id");
    print(res);
  }

  _BillDetailState(this._id);
}
