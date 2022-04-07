
import 'package:dio/dio.dart';

import '../../../app_config.dart';
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
        baseUrl: AppConfig.mainURL,
        connectTimeout: 20*1000,
        receiveTimeout: 20*1000,
      );

     dio.options.headers[
    { 'Access-Control-Allow-Origin': '*',
      'Access-Control-Allow-Methods': 'GET, POST, OPTIONS, PUT, PATCH, DELETE' ,
      'Access-Control-Allow-Headers': 'X-Requested-With,content-type',
      'Access-Control-Allow-Credentials': true
       } ];

      dio.interceptors.add(Logging());
    }


 }
