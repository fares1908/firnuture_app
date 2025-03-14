class ProductModel {
  String? id;
  String? productName;
  String? productDescription;
  int? productPrice;
  int? productSalePrice;
  int? productStock;
  String? productCategory;
  List<String>? productImages;
  String? productSKU;
  String? stockStatus;
  bool? isInCart;
  bool ?isInFav;

  ProductModel({
    this.id,
    this.productName,
    this.productDescription,
    this.productPrice,
    this.productSalePrice,
    this.productStock,
    this.productCategory,
    this.productImages,
    this.productSKU,
    this.stockStatus,
    this.isInCart,
    this.isInFav,
  });

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    productName = json['productName'];
    productDescription = json['productDescription'];
    productPrice = json['productPrice'];
    productSalePrice = json['productSalePrice'];
    productStock = json['productStock'];
    productCategory = json['productCategory'];
    productImages = List<String>.from(json['productImages'] ?? []);
    productSKU = json['productSKU'];
    stockStatus = json['stockStatus'];
    isInCart = json['isInCart'];
    isInFav = json['isInFav'];
  }
}
