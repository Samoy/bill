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
import 'package:bill/common/constant.dart';
import 'package:bill/model/bean/bill_list_bean.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BillListItem extends StatelessWidget {
  final Bill _bill;
  final Function onUpdateSuccess;

  BillListItem(this._bill, {this.onUpdateSuccess});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(_bill.name),
      leading: Container(
        width: 24,
        height: double.infinity,
        alignment: Alignment.centerLeft,
        child: Image.network(
          gBaseUrl + _bill.billType.image,
        ),
      ),
      onTap: () async {
        dynamic res = await Navigator.pushNamed(context, "/bill_detail",
            arguments: {kBillID: _bill.id}) as bool;
        if (res != null && res && onUpdateSuccess != null) {
          onUpdateSuccess();
        }
      },
      subtitle: Text(DateFormat(gDateTimeFormatter)
          .format(DateTime.tryParse(_bill.date).toLocal())),
      trailing: Text(
        "¥${double.tryParse(_bill.amount).toStringAsFixed(2)}",
        style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold),
      ),
    );
  }
}
