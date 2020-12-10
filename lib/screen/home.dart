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
import 'package:bill/common/net_manager.dart';
import 'package:bill/common/utils.dart';
import 'package:bill/model/bean/bill_list_bean.dart';
import 'package:bill/model/bill_model.dart';
import 'package:bill/screen/bill_add.dart';
import 'package:bill/screen/budget_add.dart';
import 'package:bill/widget/base.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

//fixme:下方列表应该和页面整体滑动
class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  List<_ActionItem> _actionItems = [
    _ActionItem("添加预算", BudgetAddPage()),
    _ActionItem("添加账单", BillAddPage())
  ];
  double _bottom = 20;
  double _right = 4;
  bool _isExpand = false;
  AnimationController _animationController;
  Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true);
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.linear,
    );
    fetchBillList();
  }

  @override
  Widget build(BuildContext context) {
    if (_isExpand) {
      _animationController.animateTo(0.125);
    } else {
      _animationController.animateBack(0);
    }
    return BaseWidget(
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GridView.count(
                physics: ClampingScrollPhysics(),
                childAspectRatio: 1.62,
                shrinkWrap: true,
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                padding: EdgeInsets.all(16),
                children: [
                  _GridItem("本日消费", context.watch<BillModel>().dailyAmount,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [
                            Colors.amberAccent,
                            Colors.amber,
                            Colors.orange
                          ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight))),
                  _GridItem("本周消费", context.watch<BillModel>().weeklyAmount,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [
                              Colors.limeAccent,
                              Colors.lime,
                              Colors.lime[800]
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight),
                      )),
                  _GridItem("本月消费", context.watch<BillModel>().monthlyAmount,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [
                            Colors.cyanAccent,
                            Colors.cyan,
                            Colors.lightBlue
                          ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight))),
                  _GridItem("本年消费", context.watch<BillModel>().annualAmount,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [
                            Colors.lightGreenAccent,
                            Colors.lightGreen,
                            Colors.green
                          ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight))),
                ]
                    .map((e) => Card(
                          child: Container(
                            decoration: e.decoration,
                            child: FlatButton(
                              padding: EdgeInsets.all(16),
                              child: Column(
                                children: [
                                  Align(
                                    child: Text(
                                      e.title,
                                      style: TextStyle(fontSize: 12),
                                    ),
                                    alignment: Alignment.topLeft,
                                  ),
                                  SizedBox(
                                    height: 12,
                                  ),
                                  Center(
                                    child: Text(
                                      "¥${e.amount.toStringAsFixed(2)}",
                                      style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )
                                ],
                              ),
                              onPressed: () {},
                            ),
                          ),
                        ))
                    .toList(),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  '最近7天账单',
                  style: TextStyle(
                      fontFamily: "NotoSC-Black",
                      color: Colors.amber[700],
                      fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                  flex: 1,
                  child: Container(
                    child: Consumer<BillModel>(
                      builder: (context, billModel, child) {
                        return ListView.separated(
                          physics: ClampingScrollPhysics(),
                          itemBuilder: (context, index) {
                            Bill bill = billModel.recentBillList[index];
                            return ListTile(
                              title: Text(bill.name),
                              leading: Container(
                                width: 24,
                                height: double.infinity,
                                alignment: Alignment.centerLeft,
                                child: Image.network(
                                  kBaseUrl + bill.billType.image,
                                ),
                              ),
                              onTap: () {},
                              subtitle: Text(DateFormat(kDateFormatter)
                                  .format(DateTime.parse(bill.date))),
                              trailing: Text(
                                "¥${double.tryParse(bill.amount).toStringAsFixed(2)}",
                                style: TextStyle(
                                    color: Colors.redAccent,
                                    fontWeight: FontWeight.bold),
                              ),
                            );
                          },
                          itemCount: billModel.recentBillList.length,
                          separatorBuilder: (context, index) {
                            return Divider(
                              height: 0,
                              thickness: 0.5,
                            );
                          },
                        );
                      },
                    ),
                  ))
            ],
          ),
          Container(
            child: Offstage(
              child: Stack(
                children: _actionItems
                    .map((_ActionItem item) => AnimatedPositioned(
                        child: Container(
                          height: 28,
                          width: 80,
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(1.5)),
                            gradient: LinearGradient(colors: [
                              Colors.amberAccent,
                              Colors.amber,
                              Colors.orange
                            ]),
                          ),
                          child: FlatButton(
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            child: Text(
                              item._title,
                              style: TextStyle(fontSize: 12),
                            ),
                            onPressed: () async {
                              setState(() {
                                _isExpand = false;
                                _bottom = 20;
                              });
                              bool res = await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => item._screen))
                                  as bool;
                              if (res != null && res) {
                                fetchBillList();
                              }
                            },
                          ),
                        ),
                        bottom: _bottom + 40 * (_actionItems.indexOf(item)),
                        curve: Curves.linearToEaseOut,
                        right: _right,
                        duration: Duration(milliseconds: 500)))
                    .toList(),
              ),
              offstage: !_isExpand,
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: RotationTransition(
          child: Icon(Icons.add),
          turns: _animation,
        ),
        elevation: 2,
        highlightElevation: 2,
        mini: true,
        onPressed: () {
          setState(() {
            _isExpand = !_isExpand;
            _bottom = _isExpand ? 70 : 20;
          });
        },
      ),
    );
  }

  void fetchDailyBillList() async {
    Map<String, dynamic> res = await NetManager.getInstance(context)
        .get("/api/v1/bill_list", queryParameters: {
      "start_time": getDaily().startTime,
      "end_time": getDaily().endTime,
    });
    if (res != null) {
      BillListBean billTypeListBean = BillListBean.fromJson(res);
      Provider.of<BillModel>(context, listen: false).dailyBillList =
          billTypeListBean.data;
    }
  }

  void fetchWeeklyBillList() async {
    Map<String, dynamic> res = await NetManager.getInstance(context)
        .get("/api/v1/bill_list", queryParameters: {
      "start_time": getWeekly().startTime,
      "end_time": getWeekly().endTime,
    });
    if (res != null) {
      BillListBean billTypeListBean = BillListBean.fromJson(res);
      Provider.of<BillModel>(context, listen: false).weeklyBillList =
          billTypeListBean.data;
    }
  }

  void fetchMonthlyBillList() async {
    Map<String, dynamic> res = await NetManager.getInstance(context)
        .get("/api/v1/bill_list", queryParameters: {
      "start_time": getMonthly().startTime,
      "end_time": getMonthly().endTime,
    });
    if (res != null) {
      BillListBean billTypeListBean = BillListBean.fromJson(res);
      Provider.of<BillModel>(context, listen: false).monthlyBillList =
          billTypeListBean.data;
    }
  }

  void fetchAnnualBillList() async {
    Map<String, dynamic> res = await NetManager.getInstance(context)
        .get("/api/v1/bill_list", queryParameters: {
      "start_time": getAnnual().startTime,
      "end_time": getAnnual().endTime,
    });
    if (res != null) {
      BillListBean billTypeListBean = BillListBean.fromJson(res);
      Provider.of<BillModel>(context, listen: false).annualBillList =
          billTypeListBean.data;
    }
  }

  void fetchRecentBillList() async {
    Map<String, dynamic> res = await NetManager.getInstance(context)
        .get("/api/v1/bill_list", queryParameters: {
      "start_time": getRecent().startTime,
      "end_time": getRecent().endTime,
    });
    BillListBean billTypeListBean = BillListBean.fromJson(res);
    Provider.of<BillModel>(context, listen: false).recentBillList =
        billTypeListBean.data;
  }

  void fetchBillList() {
    fetchDailyBillList();
    fetchWeeklyBillList();
    fetchMonthlyBillList();
    fetchAnnualBillList();
    fetchRecentBillList();
  }
}

class _ActionItem {
  String _title;
  Widget _screen;

  _ActionItem(this._title, this._screen);

  String get title => _title;

  Widget get screen => _screen;
}

class _GridItem {
  String _title;
  double _amount;
  BoxDecoration decoration;

  _GridItem(this._title, this._amount, {this.decoration});

  String get title => _title;

  double get amount => _amount;
}
