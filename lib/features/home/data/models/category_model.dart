class CategoryModel {
  String? id;
  String? categoryImage;
  String? categoryName;
  String? categoryDescription;

  CategoryModel({
    this.id,
    this.categoryImage,
    this.categoryDescription,
    this.categoryName,
  });

  CategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    categoryName = json['categoryname'];
    categoryDescription = json['categoryDescription'];
    categoryImage = json['categoryImage'];
  }
}
