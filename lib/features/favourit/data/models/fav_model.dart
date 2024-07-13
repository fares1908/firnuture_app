import '../../../home/data/models/product_model.dart';

class Favorite {
  final String id;
  final String userId;
  final ProductModel product;

  Favorite({
    required this.id,
    required this.userId,
    required this.product,
  });

  factory Favorite.fromJson(Map<String, dynamic> json) {
    return Favorite(
      id: json['_id'],
      userId: json['userId'],
      product: ProductModel.fromJson(json['productId']),
    );
  }
}
