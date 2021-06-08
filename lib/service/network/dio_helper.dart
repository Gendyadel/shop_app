import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class DioHelper {
  static Dio dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://student.valuxapps.com/api/',
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> getData({
    @required String url,
    dynamic query,
    String language = 'en',
    String token,
  }) async {
    dio.options.headers = {
      'Content-Type': 'application/json',
      'lang': language,
      'Authorization': token ?? '',
    };

    return await dio.get(url, queryParameters: query ?? null);
  }

  static Future<Response> postData({
    @required String url,
    @required Map<String, dynamic> data,
    Map<String, dynamic> query,
    String language = 'en',
     String token,
  }) async {
    dio.options.headers = {
      'Content-Type': 'application/json',
      'lang': language,
      'Authorization': token ?? '',
    };

    return dio.post(url, queryParameters: query, data: data);
  }

  static Future<Response> putData({
    @required String url,
    @required Map<String, dynamic> data,
    Map<String, dynamic> query,
    String language = 'en',
    String token,
  }) async {
    dio.options.headers = {
      'Content-Type': 'application/json',
      'lang': language,
      'Authorization': token ?? '',
    };

    return dio.put(url, queryParameters: query, data: data);
  }
}
