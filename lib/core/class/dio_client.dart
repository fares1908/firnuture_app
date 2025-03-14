import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:furniture_shopping/core/class/my_services.dart';
import 'package:get/instance_manager.dart';
import 'package:http/http.dart' as http;
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../constants/api_link.dart';
import 'dio_interceptors.dart';

class DioClient {
  final String baseUrl;

  Dio? dio;
  String? token;
  final MyServices myServices = Get.find<MyServices>();
  DioClient(this.baseUrl, Dio? dioC) {
    dio = dioC ?? Dio();
    dio
      ?..options.baseUrl = baseUrl
      ..options.connectTimeout = const Duration(seconds: 60)
      ..options.receiveTimeout = const Duration(seconds: 60)
      ..httpClientAdapter;
    dio!.interceptors.add(DioInterceptors());
    dio!.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90,
      ),
    );
  }

  Future<Response> get(
      String uri, {
        Map<String, dynamic>? queryParameters,
        Options? options,
        CancelToken? cancelToken,
        ProgressCallback? onReceiveProgress,
      }) async {
    try {
      var response = await dio!.get(
        uri,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    } on FormatException catch (_) {
      throw const FormatException("Unable to process the data");
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> post(
      String uri, {
        data,
        Map<String, dynamic>? queryParameters,
        Options? options,
        CancelToken? cancelToken,
        ProgressCallback? onSendProgress,
        ProgressCallback? onReceiveProgress,
      }) async {
    try {
      var response = await dio!.post(
        uri,
        data: data == null ? null : FormData.fromMap(data),
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );

      return response;
    } on FormatException catch (_) {
      throw const FormatException("Unable to process the data");
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> put(
      String uri, {
        data,
        Map<String, dynamic>? queryParameters,
        Options? options,
        CancelToken? cancelToken,
        ProgressCallback? onSendProgress,
        ProgressCallback? onReceiveProgress,
      }) async {
    try {
      var response = await dio!.put(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on FormatException catch (_) {
      throw const FormatException("Unable to process the data");
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> delete(
      String uri, {
        data,
        Map<String, dynamic>? queryParameters,
        Options? options,
        CancelToken? cancelToken,
      }) async {
    try {
      var response = await dio!.delete(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return response;
    } on FormatException catch (_) {
      throw const FormatException("Unable to process the data");
    } catch (e) {
      rethrow;
    }
  }

  Future<http.Response> postMultipartData(
      String uri,
      Map<String, String> body,
      List<MultipartBody> multipartBody, {
        Map<String, String>? headers,
      }) async {
    try {
      http.MultipartRequest request =
      http.MultipartRequest('POST', Uri.parse(AppLink.kBaseUrl + uri));
      request.headers.addAll(
          <String, String>{'Authorization': 'Bearer ${myServices.sharedPreferences.getString('token')
          }'});
      for (MultipartBody multipart in multipartBody) {
        // if (multipart.file != null) {
        if (kIsWeb) {
          Uint8List list = await multipart.file!.readAsBytes();
          http.MultipartFile part = http.MultipartFile(
            multipart.key,
            multipart.file!.readAsBytes().asStream(),
            list.length,
            filename: multipart.file!.path,
          );
          request.files.add(part);
        } else {
          File file = File(multipart.file!.path);
          request.files.add(http.MultipartFile(
            multipart.key,
            file.readAsBytes().asStream(),
            file.lengthSync(),
            filename: file.path.split('/').last,
          ));
          // request.files.add(await http.MultipartFile.fromPath(
          //         multipart.key, multipart.file!.path));

          // }
        }
      }
      request.fields.addAll(body);
      http.Response response =
      await http.Response.fromStream(await request.send());

      return response;
    } on FormatException catch (_) {
      throw const FormatException("Unable to process the data");
    } catch (e) {
      rethrow;
    }
  }
}

class MultipartBody {
  String key;
  File? file;

  MultipartBody(this.key, this.file);
}