import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../models/cart_models.dart';

class CartService {
  Future<Cart> getCart(String baseUrl, String token) async {
    final url = Uri.parse('$baseUrl/cart/getCart');
    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        if (kDebugMode) {
          print(responseBody);
        }
        return Cart.fromJson(
            responseBody['cart']); // Ensure it parses the correct key
      } else {
        throw Exception('Failed to get cart');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error in getCart: $e');
      }
      rethrow; // Rethrow the exception to be handled elsewhere
    }
  }

  Future<void> addToCart(
      String baseUrl, String productId, int quantity, String token) async {
    final url = Uri.parse('$baseUrl/cart/addToCart/$productId');
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'productId': productId,
          'quantity': quantity,
        }),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to add product to cart');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error in addToCart: $e');
      }
      rethrow;
    }
  }
  Future<void> addMultipleToCart(String baseUrl, List<String> productIds, String token) async {
    final url = Uri.parse('$baseUrl/cart/addMultipleProducts');
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'productIds': productIds,
        }),
      );

      if (kDebugMode) {
        print('Response status: ${response.statusCode}');
        print('Response body: ${response.body}');
      }

      if (response.statusCode != 200) {
        throw Exception('Failed to add multiple products to cart');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error in addMultipleToCart: $e');
      }
      rethrow;
    }
  }
  Future<void> removeFromCart(
      String productId, String baseUrl, String token) async {
    final url = Uri.parse('$baseUrl/cart/removeFromCart/$productId');
    try {
      final response = await http.delete(
        url,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to remove product from cart');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error in removeFromCart: $e');
      }
      rethrow;
    }
  }

  Future<void> deleteProductFromCart(
      String productId, String baseUrl, String token) async {
    final url = Uri.parse('$baseUrl/cart/delete/$productId');
    try {
      final response = await http.delete(
        url,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      // Log the response status and body for debugging
      if (kDebugMode) {
        print('Response status: ${response.statusCode}');
      }
      if (kDebugMode) {
        print('Response body: ${response.body}');
      }

      if (response.statusCode != 200) {
        throw Exception('Failed to delete product from cart: ${response.body}');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error in deleteProductFromCart: $e');
      }
      rethrow;
    }
  }

  Future<void> applyPromoCode(String baseUrl, String token, String promoCode) async {
    final url = Uri.parse('$baseUrl/cart/applyPromoCode');
    try {
      final response = await http.post(
        url,
        body: jsonEncode({'promoCode': promoCode}),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      // ✅ طباعة الاستجابة للتصحيح
      if (kDebugMode) {
        print('Response status: ${response.statusCode}');
        print('Response body: ${response.body}');
      }

      // ✅ استخراج رسالة الخطأ فقط بدون `Exception`
      if (response.statusCode != 200) {
        final errorResponse = jsonDecode(response.body);
        throw errorResponse['message'] ?? 'Failed to apply promo code';
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error in add promoCode: $e');
      }
      rethrow; // إعادة الخطأ بنفس الشكل
    }
  }


}
