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

import 'dart:collection';

import 'package:bill/common/constant.dart';
import 'package:bill/common/net_manager.dart';
import 'package:bill/model/bean/bill_detail_bean.dart';
import 'package:bill/model/bean/bill_list_bean.dart';
import 'package:bill/model/bean/bill_type_list_bean.dart';
import 'package:bill/model/bean/update_bill_bean.dart';
import 'package:bill/model/bill_type_model.dart';
import 'package:bill/widget/base.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:toast/toast.dart';

class BillDetail extends StatefulWidget {
  final int _id;

  @override
  _BillDetailState createState() => _BillDetailState(_id);

  BillDetail(this._id);
}

class _BillDetailState extends State<BillDetail> {
  bool _isEditing = false;
  bool _success = false;
  final int _id;
  GlobalKey<FormState> _formKey = GlobalKey();
  List<_BillItem> _items = [
    _BillItem(
      "名称",
      "name",
    ),
    _BillItem(
      "日期",
      "date",
      inputType: TextInputType.datetime,
    ),
    _BillItem(
      "时间",
      "time",
      inputType: TextInputType.datetime,
    ),
    _BillItem("金额", "amount",
        inputType: TextInputType.numberWithOptions(decimal: true)),
    _BillItem("类型", "bill_type"),
    _BillItem("备注", "remark"),
  ];
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();
  Bill _defaultBill;
  Bill _bill;
  Map<String, dynamic> _param = new HashMap();

  @override
  void initState() {
    super.initState();
    fetchBillDetail();
  }

  @override
  Widget build(BuildContext context) {
    final requiredFields = ['名称', '金额', '类型', '日期', '时间'];
    return WillPopScope(
        child: BaseWidget(
          title: "账单详情",
          actions: [
            IconButton(
              icon: _isEditing ? Icon(Icons.check) : Icon(Icons.edit),
              onPressed: () {
                if (!_isEditing) {
                  setState(() {
                    _isEditing = true;
                  });
                } else {
                  updateBill();
                  setState(() {
                    _isEditing = false;
                  });
                }
              },
              tooltip: "修改",
            )
          ],
          body: _bill == null
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : SingleChildScrollView(
                  child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: _items.map((e) {
                            return Container(
                              margin: EdgeInsets.only(top: 12),
                              child: TextFormField(
                                controller: e.controller,
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
                                decoration: InputDecoration(
                                    enabled: _isEditing,
                                    contentPadding: EdgeInsets.only(left: 8),
                                    prefixIconConstraints: BoxConstraints(
                                      maxHeight: 20,
                                      minWidth: 40,
                                    ),
                                    prefixIcon: Text("${e.title}:"),
                                    suffixText: e.title == '金额' ? "元" : null,
                                    suffixIcon: _isEditing
                                        ? requiredFields.contains(e.title)
                                            ? Container(
                                                margin:
                                                    EdgeInsets.only(left: 8),
                                                child: Text(
                                                  "*",
                                                  style: TextStyle(
                                                      color: Colors.red),
                                                ),
                                              )
                                            : null
                                        : null,
                                    suffixIconConstraints: BoxConstraints(
                                        minWidth: 16, maxHeight: 10)),
                                onTap: () async {
                                  switch (e.title) {
                                    case '日期':
                                      DateTime result = await showDatePicker(
                                          context: context,
                                          initialDate: _selectedDate,
                                          firstDate: DateTime(2000, 1, 1),
                                          lastDate: DateTime.now());
                                      if (result != null) {
                                        e.controller.text =
                                            DateFormat(gDateFormatter)
                                                .format(result);
                                        _selectedDate = result;
                                        _param[e.key] =
                                            "${DateFormat(gDateFormatter).format(result)} ${_selectedTime.format(context)}:00";
                                      }
                                      break;
                                    case '时间':
                                      TimeOfDay result = await showTimePicker(
                                          context: context,
                                          initialTime: _selectedTime,
                                          initialEntryMode:
                                              TimePickerEntryMode.input,
                                          builder: (BuildContext context,
                                              Widget child) {
                                            return MediaQuery(
                                              data: MediaQuery.of(context)
                                                  .copyWith(
                                                      alwaysUse24HourFormat:
                                                          true),
                                              child: child,
                                            );
                                          });
                                      if (result != null) {
                                        e.controller.text =
                                            result.format(context);
                                        _selectedTime = result;
                                        _param["date"] =
                                            "${DateFormat(gDateFormatter).format(_selectedDate)} ${result.format(context)}:00";
                                      }
                                      break;
                                    case '类型':
                                      bool result = await Navigator.pushNamed(
                                          context, "/bill_type_list") as bool;
                                      if (result != null && result) {
                                        BillType billType =
                                            Provider.of<BillTypeModel>(context,
                                                    listen: false)
                                                .selectBillType;
                                        e.controller.text = billType.name;
                                        _param["type_id"] = billType.id;
                                      }
                                      break;
                                    default:
                                      return null;
                                  }
                                },
                                readOnly: e.title == '时间' ||
                                    e.title == '日期' ||
                                    e.title == '类型',
                                onChanged: (value) {
                                  _param[e.key] = value;
                                },
                              ),
                            );
                          }).toList() +
                          [
                            Container(
                              child: Row(
                                children: [
                                  Flexible(
                                    child: Container(
                                      margin: EdgeInsets.only(top: 16),
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(3)),
                                          gradient: LinearGradient(colors: [
                                            Colors.amberAccent,
                                            Colors.amber,
                                            Colors.orange
                                          ])),
                                      child: FlatButton(
                                        textColor: Colors.white,
                                        onPressed: _isEditing
                                            ? () {
                                                if (_formKey.currentState
                                                    .validate()) {
                                                  updateBill();
                                                }
                                              }
                                            : null,
                                        materialTapTargetSize:
                                            MaterialTapTargetSize.shrinkWrap,
                                        child: Text(
                                          "修改",
                                          style: TextStyle(fontSize: 14),
                                        ),
                                      ),
                                    ),
                                    flex: 1,
                                  ),
                                  SizedBox(
                                    width: 16,
                                  ),
                                  Flexible(
                                    child: Container(
                                      margin: EdgeInsets.only(top: 16),
                                      width: double.infinity,
                                      child: OutlineButton(
                                        textColor: Colors.grey[600],
                                        borderSide:
                                            BorderSide(color: Colors.amber),
                                        onPressed: _isEditing
                                            ? () {
                                                if (_isEditing) {
                                                  setState(() {
                                                    _isEditing = false;
                                                    //深复制，避免因修改_bill而_defaultBill也发生改变。
                                                    _bill = Bill.fromJson(
                                                        _defaultBill.toJson());
                                                  });
                                                }
                                              }
                                            : null,
                                        materialTapTargetSize:
                                            MaterialTapTargetSize.shrinkWrap,
                                        child: Text(
                                          "取消",
                                          style: TextStyle(fontSize: 14),
                                        ),
                                      ),
                                    ),
                                    flex: 1,
                                  )
                                ],
                              ),
                            ),
                          ],
                    ),
                  ),
                )),
        ),
        onWillPop: () async {
          Navigator.pop(context, _success);
          return _success;
        });
  }

  Future fetchBillDetail() async {
    Map<String, dynamic> res =
        await NetManager.getInstance(context).get("/api/v1/bill?bill_id=$_id");
    BillDetailBean billDetailBean = BillDetailBean.fromJson(res);
    Bill bill = billDetailBean.data;
    //深复制，避免因修改_bill而_defaultBill也发生改变。
    if (_defaultBill == null) {
      _defaultBill = Bill.fromJson(bill.toJson());
      setState(() {
        _bill = Bill.fromJson(bill.toJson());
        _setController();
      });
    }
  }

  void _setController() {
    _items = _items.map((e) {
      dynamic value = _bill.toJson()[e.key == 'time' ? "date" : e.key];
      if (e.key == "bill_type") {
        Map<String, dynamic> billType = value;
        value = billType["name"];
      }
      if (e.key == "date") {
        value = DateFormat(gDateFormatter).format(DateTime.tryParse(value));
      }
      if (e.key == "time") {
        value = DateFormat(gTimeOfDayFormatter)
            .format(DateTime.tryParse(value).toLocal());
      }
      TextEditingController controller = TextEditingController.fromValue(
          TextEditingValue(
              text: value,
              selection: TextSelection.fromPosition(TextPosition(
                  affinity: TextAffinity.downstream,
                  offset: '$value'.length))));
      e.controller = controller;
      return e;
    }).toList();
  }

  _BillDetailState(this._id);

  void updateBill() async {
    if (_param.isEmpty) {
      Toast.show("未修改任何信息", context, gravity: Toast.CENTER);
      return;
    }
    _param["bill_id"] = _id;
    Map<String, dynamic> res =
        await NetManager.getInstance(context).put("/api/v1/bill", data: _param);
    UpdateBillBean updateBillBean = UpdateBillBean.fromJson(res);
    if (updateBillBean.data != null) {
      Toast.show(updateBillBean.message, context, gravity: Toast.CENTER);
      setState(() {
        _bill = updateBillBean.data;
        _isEditing = false;
        _success = true;
      });
    }
  }
}

class _BillItem {
  String title;
  String key;
  TextInputType inputType;
  TextEditingController controller;

  _BillItem(this.title, this.key, {this.inputType, this.controller});
}
