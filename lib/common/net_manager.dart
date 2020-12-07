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
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NetManager {
  var _dio = Dio();
  static NetManager _netManager;

  static NetManager getInstance() {
    if (_netManager == null) {
      _netManager = NetManager();
    }
    return _netManager;
  }

  NetManager() {
    _dio.interceptors.add(InterceptorsWrapper(onRequest: (options) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      options.baseUrl = kBaseUrl;
      options.headers["token"] = prefs.getString(kStorageToken);
    }, onError: (error) {
      Map<String, dynamic> res = error.response.data;
      String errorMsg = res["message"] as String;
      return errorMsg;
    }));
  }

  Future<Map<String, dynamic>> get(String path,
      {Map<String, dynamic> queryParameters}) async {
    Response response = await _dio.get(path, queryParameters: queryParameters);
    return response?.data as Map<String, dynamic>;
  }

  Future<Map<String, dynamic>> post(String path,
      {Map<String, dynamic> data, Map<String, dynamic> queryParameters}) async {
    Response response =
        await _dio.post(path, data: data, queryParameters: queryParameters);
    return response?.data as Map<String, dynamic>;
  }
  Future<Map<String, dynamic>> put(String path,
      {Map<String, dynamic> data, Map<String, dynamic> queryParameters}) async {
    Response response =
        await _dio.put(path, data: data, queryParameters: queryParameters);
    return response?.data as Map<String, dynamic>;
  }

  Future<Map<String, dynamic>> delete(String path,
      {Map<String, dynamic> data, Map<String, dynamic> queryParameters}) async {
    Response response =
        await _dio.delete(path, data: data, queryParameters: queryParameters);
    return response?.data as Map<String, dynamic>;
  }
}
