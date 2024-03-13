import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../functions/checkinternet.dart';
import 'status_request.dart';

class Crud {
  Future<Either<StatusRequest, Map>> postData(String linkUrl, Map data) async {
    if (await checkInternet()) {
      http.Response response = await http.post(Uri.parse(linkUrl), body: data);
      if (kDebugMode) {
        print(response.statusCode);
      }
      if (response.statusCode == 200 || response.statusCode == 201) {
        if (kDebugMode) {
          print('Response Body: ${response.body}');
        }
        Map responseBody = json.decode(response.body);
        if (kDebugMode) {
          print(responseBody);
        }
        return Right(
            responseBody); // Return a Right containing the response body
      } else {
        return const Left(
            StatusRequest.serverFailure); // Return a Left with serverfailure
      }
    } else {
      return const Left(StatusRequest.offlineFailure);
    }
  }

  Future<Either<StatusRequest, Map>> getData(String linkUrl) async {
    if (await checkInternet()) {
      http.Response response = await http.get(
        Uri.parse(linkUrl),
      );

      print(response.statusCode);
      print('Response Body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        Map responseBody = json.decode(response.body);
        print(responseBody);
        return Right(responseBody);
      } else {
        return const Left(StatusRequest.serverFailure);
      }
    } else {
      return const Left(StatusRequest.offlineFailure);
    }
  }


}
