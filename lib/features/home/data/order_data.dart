import 'dart:convert';
import 'package:furniture_shopping/core/constants/api_link.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:furniture_shopping/core/class/my_services.dart';
import 'models/order_model.dart';

class OrderService {
  MyServices myServices = Get.find();

  // ✅ Fix: Correct final String declaration
  final String baseUrl = AppLink.kBaseUrl;

  // ✅ Automatically get token
  String? get token => myServices.sharedPreferences.getString('token');

  // ✅ Fetch all orders
  Future<List<OrderModel>> getOrders() async {
    if (token == null) throw Exception("Token not found");

    final url = Uri.parse('$baseUrl/api/orders');

    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        print("📄 Orders Response: $responseBody");

        return (responseBody['data']['orders'] as List)
            .map((e) => OrderModel.fromJson(e))
            .toList();
      } else {
        throw Exception('Failed to fetch orders');
      }
    } catch (e) {
      print('❌ Error in getOrders: $e');
      rethrow;
    }
  }

  // ✅ Fetch a specific order by ID
  Future<OrderModel?> getOrderById(String orderId) async {
    if (token == null) throw Exception("Token not found");

    final url = Uri.parse('$baseUrl/api/orders/$orderId');

    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        print("📄 Order Details: $responseBody");

        return OrderModel.fromJson(responseBody['data']['order']);
      } else {
        throw Exception('Failed to fetch order');
      }
    } catch (e) {
      print('❌ Error in getOrderById: $e');
      rethrow;
    }
  }

  // ✅ Create a new order
  Future<void> createOrder(Map<String, dynamic> orderData) async {
    if (token == null) throw Exception("Token not found");

    final url = Uri.parse('$baseUrl/api/orders/addOrder');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(orderData),
      );

      if (response.statusCode != 201) {
        print('Response status: ${response.statusCode}');
        print('Response body: ${response.body}');
        throw Exception('Failed to create order');
      }
    } catch (e) {
      print('❌ Error in createOrder: $e');
      rethrow;
    }
  }

  // ✅ Cancel an order
  // Future<void> cancelOrder(String orderId) async {
  //   if (token == null) throw Exception("Token not found");
  //
  //   final url = Uri.parse('$baseUrl/api/orders/cancelOrder/$orderId');
  //
  //   try {
  //     final response = await http.delete(
  //       url,
  //       headers: {
  //         'Content-Type': 'application/json',
  //         'Authorization': 'Bearer $token',
  //       },
  //     );
  //
  //     if (response.statusCode != 200) {
  //       print('Response status: ${response.statusCode}');
  //       print('Response body: ${response.body}');
  //       throw Exception('Failed to cancel order');
  //     }
  //   } catch (e) {
  //     print('❌ Error in cancelOrder: $e');
  //     rethrow;
  //   }
  // }
}
