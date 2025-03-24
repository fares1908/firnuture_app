import 'package:intl/intl.dart';

class OrderModel {
  String id;
  String orderNumber;
  List<ProductOrder> products;
  double totalAmount;
  String status;
  DateTime createdAt;

  OrderModel({
    required this.id,
    required this.orderNumber,
    required this.products,
    required this.totalAmount,
    required this.status,
    required this.createdAt,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json["_id"],
      orderNumber: json["_id"].substring(0, 8), // ✅ عرض جزء من رقم الطلب
      products: (json["products"] as List)
          .map((product) => ProductOrder.fromJson(product))
          .toList(),
      totalAmount: double.parse(json["totalAmount"].toString()),
      status: json["status"],
      createdAt: DateTime.parse(json["createdAt"]),
    );
  }

  // ✅ تنسيق التاريخ ليكون أكثر وضوحًا
  String getFormattedDate() {
    return DateFormat('yyyy-MM-dd HH:mm').format(createdAt);
  }
}

class ProductOrder {
  String id;
  String name;
  String image;
  String description;
  String category;
  double price;
  int stock;
  int quantity;
  double subtotal;

  ProductOrder({
    required this.id,
    required this.name,
    required this.image,
    required this.description,
    required this.category,
    required this.price,
    required this.stock,
    required this.quantity,
    required this.subtotal,
  });

  factory ProductOrder.fromJson(Map<String, dynamic> json) {
    return ProductOrder(
      id: json["productId"]["_id"],
      name: json["productId"]["name"],
      image: json["productId"]["image"], // ✅ تأكد إن الصورة بترجع كـ URL كامل
      description: json["productId"]["description"] ?? "No description available",
      category: json["productId"]["category"] ?? "Uncategorized",
      price: double.parse(json["productId"]["price"].toString()),
      stock: json["productId"]["stock"] ?? 0,
      quantity: json["quantity"],
      subtotal: json["quantity"] * double.parse(json["productId"]["price"].toString()), // ✅ حساب الإجمالي للمنتج
    );
  }
}
