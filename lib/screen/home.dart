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

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  List<String> _actionItems = ["添加预算", "添加账单"];
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
  }

  @override
  Widget build(BuildContext context) {
    if (_isExpand) {
      _animationController.animateTo(0.125);
    } else {
      _animationController.animateBack(0);
    }
    return BaseWidget(
      body: Container(
        child: Offstage(
          child: Stack(
            children: _actionItems
                .map((String item) => AnimatedPositioned(
                    child: Container(
                      height: 28,
                      width: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(1.5)),
                        gradient: LinearGradient(colors: [
                          Colors.amberAccent,
                          Colors.amber,
                          Colors.orange
                        ]),
                      ),
                      child: FlatButton(
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        textColor: Colors.white,
                        child: Text(
                          item,
                          style: TextStyle(fontSize: 12),
                        ),
                        onPressed: () {},
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
      ),
      floatingActionButton: FloatingActionButton(
        foregroundColor: Colors.white,
        child: RotationTransition(
          child: Icon(Icons.add),
          turns: _animation,
        ),
        elevation: 2,
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
}
