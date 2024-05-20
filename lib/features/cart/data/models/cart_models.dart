import 'package:furniture_shopping/features/home/data/models/product_model.dart';

class Cart {
  String? id;
  String? userId;
  List<CartItem> products;
  double totalPrice;

  Cart({
    this.id,
    this.userId,
    required this.products,
    required this.totalPrice,
  });

  factory Cart.fromJson(Map<String, dynamic> json) {
    var productList = json['products'] as List;
    List<CartItem> products = productList.map((i) => CartItem.fromJson(i)).toList();

    return Cart(
      id: json['_id'],
      userId: json['userId'],
      products: products,
      totalPrice: json['totalPrice'].toDouble(),
    );
  }
}

class CartItem {
  String? id;
  ProductModel? product;
  int quantity;

  CartItem({
    this.id,
    this.product,
    required this.quantity,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json['_id'],
      product: json['productId'] != null ? ProductModel.fromJson(json['productId']) : null,
      quantity: json['quantity'],
    );
  }
}
