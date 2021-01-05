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
import 'package:bill/model/bean/bill_list_bean.dart';
import 'package:bill/model/bill_model.dart';
import 'package:bill/widget/base.dart';
import 'package:bill/widget/bill_list_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BillListPage extends StatefulWidget {
  final String _title;
  final String _startTime;
  final String _endTime;

  BillListPage(this._title, this._startTime, this._endTime);

  @override
  _BillListPageState createState() => _BillListPageState();
}

class _BillListPageState extends State<BillListPage> {
  bool _isLoading = false;
  bool _hasMore = true;
  int _page = 1;
  final int _pageSize = 10;

  @override
  void initState() {
    super.initState();
    refresh();
  }

  Future<void> refresh() {
    setState(() {
      _isLoading = false;
    });
    context.read<BillModel>().currentList = [];
    _page = 1;
    return fetchList();
  }

  Future<void> loadMore() {
    setState(() {
      _isLoading = true;
      _hasMore = true;
    });
    _page++;
    return fetchList();
  }

  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      title: widget._title,
      body: RefreshIndicator(
        child: Column(
          children: [
            Container(
                child: NotificationListener<ScrollNotification>(
              onNotification: (t) {
                if (!_isLoading &&
                    t.metrics.pixels == t.metrics.maxScrollExtent) {
                  _page++;
                  loadMore();
                }
                return false;
              },
              child: Consumer<BillModel>(
                builder: (context, billModel, child) {
                  return ListView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      itemBuilder: (context, index) {
                        return BillListItem(
                          billModel.currentList[index],
                          onUpdateSuccess: refresh,
                        );
                      },
                      itemCount: billModel.currentList.length);
                },
              ),
            )),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                _hasMore ? "正在努力加载数据 (●ﾟωﾟ●)" : "没有更多数据啦！╮(╯▽╰)╭",
                style: TextStyle(fontSize: 12, color: Color(0xFFCCCCCC)),
              ),
            ),
          ],
        ),
        onRefresh: refresh,
      ),
    );
  }

  Future<void> fetchList() async {
    Map<String, dynamic> res = await NetManager.getInstance(context)
        .get("/api/v1/bill/list", queryParameters: {
      "page": _page,
      "page_size": _pageSize,
      "start_time": widget._startTime,
      "end_time": widget._endTime
    });
    setState(() {
      _isLoading = false;
    });
    BillListBean bean = BillListBean.fromJson(res);
    if (bean.data.length < _pageSize) {
      setState(() {
        _hasMore = false;
      });
    }
    Provider.of<BillModel>(context, listen: false).currentList =
        context.read<BillModel>().currentList + bean.data;
  }
}
