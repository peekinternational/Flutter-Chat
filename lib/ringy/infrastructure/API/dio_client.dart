import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_chat/ringy/infrastructure/API/api_content.dart';
import 'logging.dart';

class DioClient
 {

   static final DioClient _instance = DioClient._();
   DioClient._();

   static DioClient get instance => _instance;

   Dio getDioClient(){
     final Dio _dio = Dio();
     onHTTPCreate(_dio);
     return _dio;
   }

    static void onHTTPCreate(Dio dio){
     dio.options = BaseOptions(
        baseUrl: APIContent.mainURL,
        connectTimeout: 20*1000,
        receiveTimeout: 20*1000,
      );

     // httpServletResponse?.setHeader("Access-Control-Allow-Origin", "*")
     // httpServletResponse?.setHeader("Access-Control-Allow-Headers", "*")
     // httpServletResponse?.setHeader("Access-Control-Allow-Methods", "*")
     // httpServletResponse?.setHeader("Access-Control-Allow-Credentials", "true")


     dio.options.headers[
    { 'Access-Control-Allow-Origin': '*',
      'Access-Control-Allow-Methods': 'GET, POST, OPTIONS, PUT, PATCH, DELETE' ,
      'Access-Control-Allow-Headers': 'X-Requested-With,content-type',
      'Access-Control-Allow-Credentials': true
       } ];

      // if (!kIsWeb) {
      //   (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
      //       (HttpClient client) {
      //     client.badCertificateCallback =
      //         (X509Certificate cert, String host, int port) => true;
      //     return client;
      //   };
      // }
      dio.interceptors.add(Logging());
    }


 }
