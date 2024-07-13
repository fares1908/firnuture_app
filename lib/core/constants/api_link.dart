class AppLink {
  static const String server = 'http://192.168.1.30:3000';
  static const String login =
      '$server/api/users/login';
  static const String register =
      '$server/api/users/register';
  static const String getUsers =
      '$server/api/users';
  static const String getCategory =
      '$server/api/categories/getCategories';
  static const String getProducts =
      '$server/api/products/getProducts';
  static const String getSliders =
      '$server/api/sliders/getAllSliders';
  static const String getCart =
      '$server/cart/getCart';
  static const String addCart =
      '$server/cart/addToCart';
  static const String removeCart =
      '$server/removeFromCart/';

}
