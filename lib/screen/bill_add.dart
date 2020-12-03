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
import 'package:bill/widget/base.dart';
import 'package:flutter/material.dart';

class BillAddPage extends StatefulWidget {
  @override
  _BillAddPageState createState() => _BillAddPageState();
}

class _BillAddPageState extends State<BillAddPage> {
  GlobalKey _formKey = GlobalKey();
  DateTime _selectedDate = DateTime.now();
  List<_BillItem> _items = [
    _BillItem("名称", icon: Icons.account_balance_wallet_outlined),
    _BillItem("时间", icon: Icons.calendar_today_outlined),
    _BillItem("金额", icon: Icons.money_outlined),
    _BillItem("类型", icon: Icons.category_outlined),
    _BillItem("备注", icon: Icons.comment_outlined),
  ];

  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      title: "添加账单",
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: _formKey,
            child: Column(
              children: _items
                      .map((e) => Container(
                            margin: EdgeInsets.only(top: 16),
                            child: TextFormField(
                              decoration: InputDecoration(
                                  labelText: e.title,
                                  alignLabelWithHint: true,
                                  contentPadding: EdgeInsets.zero,
                                  prefixIconConstraints: BoxConstraints(
                                      minWidth: 32, maxHeight: 0),
                                  prefixIcon: Icon(
                                    e.icon,
                                    size: 16,
                                  )),
                            ),
                          ))
                      .toList() +
                  [
                    Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(top: 16),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(3)),
                          gradient: LinearGradient(colors: [
                            Colors.amberAccent,
                            Colors.amber,
                            Colors.orange
                          ])),
                      child: FlatButton(
                        textColor: Colors.white,
                        onPressed: () {},
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        child: Text("完成添加"),
                      ),
                    ),
                  ],
            ),
          ),
        ),
      ),
    );
  }
}

class _BillItem {
  String title;
  IconData icon;

  _BillItem(this.title, {this.icon});
}
