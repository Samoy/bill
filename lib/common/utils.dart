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
import 'package:intl/intl.dart';

class TimeRange {
  String _startTime;
  String _endTime;

  TimeRange(this._startTime, this._endTime);

  String get endTime => _endTime;

  String get startTime => _startTime;
}

DateTime today =
    DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
String todayFormat = DateFormat(kDateFormatter).format(today);

TimeRange getDaily() {
  return TimeRange(todayFormat, todayFormat);
}

TimeRange getWeekly() {
  int weekDay = DateTime.now().weekday;
  DateTime firstDayOfWeek = today;
  if (weekDay > 1) {
    firstDayOfWeek = DateTime.now().subtract(Duration(days: weekDay - 1));
  }
  return TimeRange(
      DateFormat(kDateFormatter).format(firstDayOfWeek), todayFormat);
}

TimeRange getMonthly() {
  DateTime firstDayOfMonth = DateTime(today.year, today.month, 1);
  return TimeRange(
      DateFormat(kDateFormatter).format(firstDayOfMonth), todayFormat);
}

TimeRange getAnnual() {
  DateTime firstDayOfYear = DateTime(today.year);
  return TimeRange(
      DateFormat(kDateFormatter).format(firstDayOfYear), todayFormat);
}

TimeRange getRecent() {
  DateTime before7Day = today.subtract(Duration(days: 6));
  return TimeRange(DateFormat(kDateFormatter).format(before7Day), todayFormat);
}
