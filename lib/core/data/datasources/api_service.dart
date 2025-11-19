
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class ApiService {
  final Dio dio;

  ApiService({Dio? client}): dio = client ?? Dio (){
    dio.options.baseUrl= 'https://dummyjson.com/';
    dio.options.connectTimeout = const Duration(seconds: 15);
    dio.options.receiveTimeout = const Duration(seconds: 15);
    dio.interceptors.add(PrettyDioLogger(
      requestHeader:true,
      requestBody:true,
      responseBody:true,
      compact:true,
    ));
  }
  Future <Response> get (String path , {Map <String , dynamic>? query}) async {
    return dio.get(path, queryParameters: query );

  }
}