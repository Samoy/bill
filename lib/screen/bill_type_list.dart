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
import 'package:bill/model/bean/bill_type_list_bean.dart';
import 'package:bill/model/bill_type_model.dart';
import 'package:bill/widget/base.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// TODO:这个列表可以使用[SliverAnimatedList]实现增加和删除动画
class BillTypeListPage extends StatefulWidget {
  @override
  _BillTypeListPageState createState() => _BillTypeListPageState();
}

class _BillTypeListPageState extends State<BillTypeListPage> {
  @override
  void initState() {
    super.initState();
    fetchBillTypeList();
  }

  @override
  Widget build(BuildContext context) {
    return BaseWidget(
        title: "账单类型",
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {},
            tooltip: "添加",
          )
        ],
        body: Consumer<BillTypeModel>(
          builder: (context, billTypeModel, child) {
            return ListView(
              children: billTypeModel.billTypeList
                  .map((item) => ListTile(
                        dense: true,
                        leading: Image.network(
                          kBaseUrl + item.image,
                          width: 24,
                          height: 24,
                        ),
                        title: Text(item.name),
                        onTap: () {
                          billTypeModel
                              .select(billTypeModel.billTypeList.indexOf(item));
                          Navigator.pop(context, true);
                        },
                      ))
                  .toList(),
            );
          },
        ));
  }

  ///TODO:这个似乎可以用[FutureProvider]来搞
  void fetchBillTypeList() async {
    Map<String, dynamic> res =
        await NetManager.getInstance(context).get("/api/v1/bill_type_list");
    BillTypeListBean billTypeListBean = BillTypeListBean.fromJson(res);
    Provider.of<BillTypeModel>(context, listen: false)
        .set(billTypeListBean.data);
  }
}
