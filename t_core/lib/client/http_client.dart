import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:t_core/t_core.dart';

@immutable
class HttpClient {
  final Dio _dio;

  HttpClient.init(Dio dio) : _dio = dio;

  static Map<String, dynamic> _getParams(Map<String, dynamic> params) =>
      params ?? <String, dynamic>{};

  static Options _getOptions(Options options) =>
      options is Options ? options : Options(responseType: ResponseType.plain);

  Future<T> get<T>(String path,
      {Map<String, dynamic> params, Options options}) {
    return _dio
        .get<T>(path,
            queryParameters: _getParams(params), options: _getOptions(options))
        .then(_handleResult)
        .catchError((dynamic e) => _handleError(path, e));
  }

  Future<T> post<T>(String path, dynamic body,
      {Map<String, dynamic> params,
      ProgressCallback onSendProgress,
      Options options}) {
    return _dio
        .post<T>(path,
            data: body,
            queryParameters: _getParams(params),
            onSendProgress: onSendProgress,
            options: _getOptions(options))
        .then(_handleResult)
        .catchError((dynamic e) => _handleError(path, e));
  }

  Future<T> put<T>(String path, dynamic body, {Options options}) {
    return _dio
        .put<T>(path, data: body, options: _getOptions(options))
        .then(_handleResult)
        .catchError((dynamic e) => _handleError(path, e));
  }

  Future<T> delete<T>(String path, {Options options}) {
    return _dio
        .delete<T>(path, options: _getOptions(options))
        .then(_handleResult)
        .catchError((dynamic e) => _handleError(path, e));
  }

  FutureOr<T> _handleResult<T>(Response<dynamic> response) {
    return Future<T>.value(null);
    // try{
    //   Map<String,dynamic> json = jsonDecode(response.data);
    //   if(!json['success']) {
    //     throw new XedAPIException.fromJson(json['error']);
    //   }
    //   return json['data'];
    // }on XedAPIException catch(e) {
    //   throw e;
    // }catch(e) {
    //   throw XedAPIException.from(e);
    // }
  }

  void _handleError(String path, DioError e) {
    try {
      Log.error('$path: $e');
      if (e.response != null && e.response.data != null) {
        Map<String, dynamic> jsonEx = json.decode(e.response.data);

        throw TApiExecption.fromJson(jsonEx['error']);
      } else {
        // throw XedAPIException.from(e);
      }
    } catch (e) {
      // throw TExecption.fromJson();
    }
  }
}
