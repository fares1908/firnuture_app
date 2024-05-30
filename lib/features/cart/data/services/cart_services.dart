import 'dart:convert';
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
        print(responseBody);
        return Cart.fromJson(responseBody['cart']); // Ensure it parses the correct key
      } else {
        throw Exception('Failed to get cart');
      }
    } catch (e) {
      print('Error in getCart: $e');
      rethrow; // Rethrow the exception to be handled elsewhere
    }
  }

  Future<void> addToCart(String baseUrl, String productId, int quantity, String token) async {
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

      if (response.statusCode != 200 ) {
        throw Exception('Failed to add product to cart');
      }
    } catch (e) {
      print('Error in addToCart: $e');
      rethrow;
    }
  }

  Future<void> removeFromCart(String productId, String baseUrl, String token) async {
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
      print('Error in removeFromCart: $e');
      rethrow;
    }
  }
  Future<void> deleteProductFromCart(String productId, String baseUrl, String token) async {
    final url = Uri.parse('$baseUrl/cart/delete/$productId');
    try {
      final response = await http.delete(
        url,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      // Log the response status and body for debugging
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode != 200) {
        throw Exception('Failed to delete product from cart: ${response.body}');
      }
    } catch (e) {
      print('Error in deleteProductFromCart: $e');
      rethrow;
    }
  }

}
