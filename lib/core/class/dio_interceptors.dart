import 'dart:io';
import 'package:dio/dio.dart';
import 'package:get/instance_manager.dart';

import 'my_services.dart';

class DioInterceptors extends Interceptor {
  final MyServices myServices = Get.find<MyServices>();
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    if (myServices.sharedPreferences.get('token') != null) {
      options.headers['Authorization'] = 'Bearer ${myServices.sharedPreferences.getString('token')}';
    }
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    super.onError(err, handler);
  }
}
