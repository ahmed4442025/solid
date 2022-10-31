import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../../app/app_constants.dart';

const String APPLICATION_JSON = "application/json";
const String CONTENT_TYPE = "content-type";
const String ACCEPT = "accept";
const String ACCEPT_Value = "*/*";
const String Accept_Encoding = "Accept_Encoding";
const String Accept_Encoding_value = "gzip, deflate, br";

class DioFactory {
  Future<Dio> getDio() async {
    Dio dio = Dio();

    Map<String, String> headers = {
      CONTENT_TYPE: APPLICATION_JSON,
      ACCEPT: ACCEPT_Value,
      Accept_Encoding: Accept_Encoding_value
    };

    dio.options = BaseOptions(
        baseUrl: "https://jsonplaceholder.typicode.com", headers: headers);


    // use proxy
    if (AppConstants.useProxyDio) {
      (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (client) {
        client.findProxy = (url) {
          return 'PROXY ${AppConstants.proxy}';
        };

        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => Platform.isAndroid;
        return null;
      };
    }

    return dio;
  }
}
