import 'dart:convert';
import 'package:furniture_shopping/features/favourit/data/models/fav_model.dart';
import 'package:http/http.dart' as http;

class FavouriteService {
  Future<List<Favorite>> getFavorites(String baseUrl, String token) async {
    final url = Uri.parse('$baseUrl/favourite/getFav');
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
        return (responseBody['favorites'] as List)
            .map((e) => Favorite.fromJson(e))
            .toList();
      } else {
        throw Exception('Failed to get favorites');
      }
    } catch (e) {
      print('Error in getFavorites: $e');
      rethrow;
    }
  }

  Future<void> addToFavorites(String baseUrl, String productId, String token) async {
    final url = Uri.parse('$baseUrl/favourite/addToFav/$productId');
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'productId': productId,
        }),
      );

      if (response.statusCode != 200) {
        print('Response status: ${response.statusCode}');
        print('Response body: ${response.body}');
        throw Exception('Failed to add product to favorites');
      }
    } catch (e) {
      print('Error in addToFavorites: $e');
      rethrow;
    }
  }

  Future<void> removeFromFavorites(String productId, String baseUrl, String token) async {
    final url = Uri.parse('$baseUrl/favourite/removeFromFav/$productId');
    try {
      final response = await http.delete(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'productId': productId,
        }),
      );

      if (response.statusCode != 200) {
        print('Response status: ${response.statusCode}');
        print('Response body: ${response.body}');
        throw Exception('Failed to remove product from favorites: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error in removeFromFavorites: $e');
      rethrow;
    }
  }
}
