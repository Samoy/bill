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
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

enum TimeUnit { YEAR, MONTH, WEEK, DAY, HOUR, MINUTE }

class TimeRange {
  String _startTime;
  String _endTime;

  TimeRange(this._startTime, this._endTime);

  String get endTime => _endTime;

  String get startTime => _startTime;
}

TimeRange getDaily() {
  DateTime now = DateTime.now();
  return TimeRange(
      DateFormat(gDateTimeFormatter)
          .format(DateTime(now.year, now.month, now.day)),
      DateFormat(gDateTimeFormatter).format(now));
}

TimeRange getWeekly() {
  DateTime now = DateTime.now();
  DateTime firstDayOfWeek = DateTime(now.year, now.month, now.day);
  if (now.weekday != DateTime.monday) {
    firstDayOfWeek =
        firstDayOfWeek.subtract(Duration(days: now.weekday - DateTime.monday));
  }
  return TimeRange(DateFormat(gDateTimeFormatter).format(firstDayOfWeek),
      DateFormat(gDateTimeFormatter).format(now));
}

TimeRange getMonthly() {
  DateTime now = DateTime.now();
  DateTime firstDayOfMonth = DateTime(now.year, now.month);
  return TimeRange(DateFormat(gDateTimeFormatter).format(firstDayOfMonth),
      DateFormat(gDateTimeFormatter).format(now));
}

TimeRange getAnnual() {
  DateTime now = DateTime.now();
  DateTime firstDayOfYear = DateTime(now.year);
  return TimeRange(DateFormat(gDateTimeFormatter).format(firstDayOfYear),
      DateFormat(gDateTimeFormatter).format(now));
}
