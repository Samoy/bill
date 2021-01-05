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
import 'package:bill/model/bean/bill_list_bean.dart';
import 'package:bill/model/bean/bill_overview_bean.dart';
import 'package:bill/model/bill_model.dart';
import 'package:bill/screen/bill_add.dart';
import 'package:bill/screen/budget_add.dart';
import 'package:bill/utils/time.dart';
import 'package:bill/widget/base.dart';
import 'package:bill/widget/bill_list_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  List<_ActionItem> _actionItems = [
    _ActionItem("添加预算", BudgetAddPage()),
    _ActionItem("添加账单", BillAddPage())
  ];
  double _bottom = 40;
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
    fetchBill();
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
          Consumer<BillModel>(
            builder: (context, billModel, child) {
              List<_OverviewItem> gridItems = [
                _OverviewItem("今日消费", billModel.overview.todayAmount,
                    label: "今日账单",
                    timeRange: getDaily(),
                    decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [
                      Colors.amberAccent,
                      Colors.amber,
                      Colors.orange
                    ], begin: Alignment.topLeft, end: Alignment.bottomRight))),
                _OverviewItem("本周消费", billModel.overview.weekAmount,
                    label: "本周账单",
                    timeRange: getWeekly(),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                        Colors.limeAccent,
                        Colors.lime,
                        Colors.lime[800]
                      ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                    )),
                _OverviewItem("本月消费", billModel.overview.monthAmount,
                    label: "本月账单",
                    timeRange: getMonthly(),
                    decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [
                      Colors.cyanAccent,
                      Colors.cyan,
                      Colors.lightBlue
                    ], begin: Alignment.topLeft, end: Alignment.bottomRight))),
                _OverviewItem("本年消费", billModel.overview.annualAmount,
                    label: "本年账单",
                    timeRange: getAnnual(),
                    decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [
                      Colors.lightGreenAccent,
                      Colors.lightGreen,
                      Colors.green
                    ], begin: Alignment.topLeft, end: Alignment.bottomRight))),
              ];
              return RefreshIndicator(
                onRefresh: fetchBill,
                child: CustomScrollView(
                  slivers: [
                    SliverPadding(
                      padding: EdgeInsets.all(16),
                      sliver: SliverGrid.count(
                        childAspectRatio: 1.62,
                        crossAxisCount: 2,
                        mainAxisSpacing: 8,
                        crossAxisSpacing: 8,
                        children: gridItems
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
                                              "¥${double.tryParse(e.amount).toStringAsFixed(2)}",
                                              style: TextStyle(
                                                  fontSize: 24,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          )
                                        ],
                                      ),
                                      onPressed: () {
                                        Navigator.pushNamed(
                                            context, "/bill_list",
                                            arguments: {
                                              kTitle: e.label,
                                              kStartTime: e.timeRange.startTime,
                                              kEndTime: e.timeRange.endTime
                                            });
                                      },
                                    ),
                                  ),
                                ))
                            .toList(),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          '最近7天账单',
                          style: TextStyle(
                              fontFamily: "NotoSC-Black",
                              color: Colors.amber[700],
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    SliverFixedExtentList(
                      itemExtent: 70,
                      delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                        Bill bill = billModel.recentBillList[index];
                        return BillListItem(
                          bill,
                          onUpdateSuccess: fetchBill,
                        );
                      }, childCount: billModel.recentBillList.length),
                    ),
                    SliverToBoxAdapter(
                      child: Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          '没有更多数据啦！╮(╯▽╰)╭',
                          style:
                              TextStyle(fontSize: 12, color: Color(0xFFCCCCCC)),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          Container(
            child: Offstage(
              child: Stack(
                children: _actionItems
                    .map((_ActionItem item) => AnimatedPositioned(
                        child: Container(
                          height: 35,
                          width: 100,
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
                                fetchBill();
                              }
                            },
                          ),
                        ),
                        bottom: _bottom + 50 * (_actionItems.indexOf(item)),
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
        onPressed: () {
          setState(() {
            _isExpand = !_isExpand;
            _bottom = _isExpand ? 80 : 40;
          });
        },
      ),
    );
  }

  Future<void> fetchBill() {
    return Future.wait([fetchBillOverview(), fetchRecentBillList()])
        .catchError((error) {
      print("发生了错误:$error");
      Toast.show("获取账单失败，请稍后再试", context, gravity: Toast.CENTER);
    });
  }

  Future<void> fetchBillOverview() async {
    Map<String, dynamic> res =
        await NetManager.getInstance(context).get("/api/v1/bill/overview");
    BillOverviewBean billOverviewBean = BillOverviewBean.fromJson(res);
    Provider.of<BillModel>(context, listen: false).overview =
        billOverviewBean.data;
  }

  Future<void> fetchRecentBillList() async {
    Map<String, dynamic> res =
        await NetManager.getInstance(context).get("/api/v1/bill/recent");
    BillListBean billListBean = BillListBean.fromJson(res);
    Provider.of<BillModel>(context, listen: false).recentBillList =
        billListBean.data;
  }
}

class _ActionItem {
  String _title;
  Widget _screen;

  _ActionItem(this._title, this._screen);

  String get title => _title;

  Widget get screen => _screen;
}

class _OverviewItem {
  String _title;
  String _amount;
  BoxDecoration decoration;
  String label;
  TimeRange timeRange;

  _OverviewItem(this._title, this._amount,
      {this.decoration, this.label, this.timeRange});

  String get title => _title;

  String get amount => _amount;
}
