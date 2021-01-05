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
import 'package:bill/screen/home.dart';
import 'package:bill/screen/mine.dart';
import 'package:bill/screen/trend.dart';
import 'package:flutter/material.dart';

class IndexPage extends StatefulWidget {
  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  List<_BottomItem> _navItems = [
    _BottomItem("首页", Icon(Icons.home), HomePage()),
    _BottomItem("趋势", Icon(Icons.trending_up), TrendPage()),
    _BottomItem("我的", Icon(Icons.person), MinePage())
  ];
  int _selectItem = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        children: _navItems.map((e) => e.screen).toList(),
        index: _selectItem,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectItem,
        onTap: (index) {
          setState(() {
            _selectItem = index;
          });
        },
        items: _navItems
            .map((_BottomItem e) =>
            BottomNavigationBarItem(label: e.label, icon: e.icon))
            .toList(),
      ),
    );
  }
}

class _BottomItem {
  String label;
  Icon icon;
  Widget screen;

  _BottomItem(this.label, this.icon, this.screen);
}
