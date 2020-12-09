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
import 'package:bill/model/bean/bill_type_list_bean.dart';
import 'package:bill/model/bill_type_model.dart';
import 'package:bill/widget/base.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:dio/dio.dart';
import 'package:toast/toast.dart';

class BillAddPage extends StatefulWidget {
  @override
  _BillAddPageState createState() => _BillAddPageState();
}

class _BillAddPageState extends State<BillAddPage> {
  List<_BillItem> _items = [
    _BillItem("名称", icon: Icons.account_balance_wallet_outlined),
    _BillItem("时间",
        icon: Icons.calendar_today_outlined, inputType: TextInputType.datetime),
    _BillItem("金额",
        icon: Icons.money_outlined,
        inputType: TextInputType.numberWithOptions(decimal: true)),
    _BillItem("类型", icon: Icons.category_outlined),
    _BillItem("备注", icon: Icons.comment_outlined),
  ];

  final _formKey = GlobalKey<FormState>();
  String _name = "";
  DateTime _selectedDate = DateTime.now();
  TextEditingController _dateController = TextEditingController(
      text: DateFormat('yyyy-MM-dd').format(DateTime.now()));
  TextEditingController _categoryController = TextEditingController();
  String _remark = "";
  double _amount = 0;
  int _billTypeId;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final requiredFields = ['名称', '金额', '类型', '时间'];
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
                              validator: (value) {
                                if (requiredFields.contains(e.title)) {
                                  if (value.isEmpty) {
                                    return "${e.title}不能为空";
                                  }
                                }
                                if (e.title == '金额' &&
                                    (!new RegExp(
                                                r"^([1-9]\d{0,9}|0)(\.\d{1,2})?$")
                                            .hasMatch(value) ||
                                        double.tryParse(value) == null ||
                                        double.tryParse(value) <= 0)) {
                                  return "不合法的金额";
                                }
                                return null;
                              },
                              keyboardType: e.inputType,
                              controller: e.title == '时间'
                                  ? _dateController
                                  : e.title == '类型'
                                      ? _categoryController
                                      : null,
                              decoration: InputDecoration(
                                  labelText: e.title,
                                  alignLabelWithHint: true,
                                  contentPadding: EdgeInsets.zero,
                                  prefixIconConstraints: BoxConstraints(
                                      minWidth: 32, maxHeight: 0),
                                  prefixIcon: Icon(
                                    e.icon,
                                    size: 16,
                                  ),
                                  suffixText: e.title == '金额' ? "元" : null,
                                  suffixIcon: requiredFields.contains(e.title)
                                      ? Container(
                                          margin: EdgeInsets.only(left: 8),
                                          child: Text(
                                            "*",
                                            style: TextStyle(color: Colors.red),
                                          ),
                                        )
                                      : null,
                                  suffixIconConstraints: BoxConstraints(
                                      minWidth: 16, maxHeight: 8)),
                              onTap: e.title == '时间'
                                  ? () async {
                                      DateTime result = await showDatePicker(
                                          context: context,
                                          initialDate: _selectedDate,
                                          firstDate: DateTime(2000, 1, 1),
                                          lastDate: DateTime.now());
                                      if (result != null) {
                                        setState(() {
                                          _selectedDate = result;
                                        });
                                        _dateController.text =
                                            DateFormat('yyyy-MM-dd')
                                                .format(_selectedDate);
                                      }
                                    }
                                  : e.title == '类型'
                                      ? () async {
                                          bool result =
                                              await Navigator.pushNamed(context,
                                                  "/bill_type_list") as bool;
                                          if (result != null && result) {
                                            BillType billType =
                                                Provider.of<BillTypeModel>(
                                                        context,
                                                        listen: false)
                                                    .selectBillType;
                                            _categoryController.text =
                                                billType.name;
                                            _billTypeId = billType.id;
                                          }
                                        }
                                      : null,
                              readOnly: e.title == '时间' || e.title == '类型',
                              onChanged: (value) {
                                if ('名称' == e.title) {
                                  setState(() {
                                    _name = value;
                                  });
                                }
                                if ('备注' == e.title) {
                                  setState(() {
                                    _remark = value;
                                  });
                                }
                                if ('金额' == e.title) {
                                  setState(() {
                                    _amount = double.tryParse(value);
                                  });
                                }
                              },
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
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            addBill();
                          }
                        },
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

  void addBill() async {
    EasyLoading.show(status: "请稍后...");
    try {
      Map<String, dynamic> res =
          await NetManager.getInstance(context).post("/api/v1/bill", data: {
        "name": _name,
        "amount": _amount,
        "date": _dateController.text,
        "type_id": _billTypeId,
        "remark": _remark,
        "income": false,
      });
      if (res != null) {
        Toast.show("账单添加成功", context, gravity: Toast.CENTER);
        Navigator.pop(context, true);
      }
    } on DioError catch (e) {
      Toast.show(e.message, context, gravity: Toast.CENTER);
    } finally {
      EasyLoading.dismiss();
    }
  }
}

class _BillItem {
  String title;
  IconData icon;
  TextInputType inputType;

  _BillItem(this.title, {this.icon, this.inputType});
}
