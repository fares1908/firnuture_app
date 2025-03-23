class UserModel {
  final String id;
  final String name;
  final String email;
  final String avatar;
  final int ordersCount;
  final int addressesCount;
  final int paymentCardsCount;
  final int reviewsCount;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.avatar,
    required this.ordersCount,
    required this.addressesCount,
    required this.paymentCardsCount,
    required this.reviewsCount,
  });

  /// ✅ **تحويل JSON إلى كائن `UserModel`**
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      avatar: json['avatar'], // تأكد أن المسار كامل وصالح للعرض
      ordersCount: json['ordersCount'] ?? 0,
      addressesCount: json['addressesCount'] ?? 0,
      paymentCardsCount: json['paymentCardsCount'] ?? 0,
      reviewsCount: json['reviewsCount'] ?? 0,
    );
  }

  /// ✅ **تحويل `UserModel` إلى JSON**
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "email": email,
      "avatar": avatar,
      "ordersCount": ordersCount,
      "addressesCount": addressesCount,
      "paymentCardsCount": paymentCardsCount,
      "reviewsCount": reviewsCount,
    };
  }
}
