class AppLink {
  static const String kBaseUrl = 'http://192.168.1.12:3000';

  // ✅ المستخدمين
  static const String login = '$kBaseUrl/api/users/login';
  static const String register = '$kBaseUrl/api/users/register';
  static const String getUsers = '$kBaseUrl/api/users';

  // ✅ الفئات والمنتجات
  static const String getCategory = '$kBaseUrl/api/categories/getCategories';
  static const String getProducts = '$kBaseUrl/api/products/getProducts';
  static const String getSliders = '$kBaseUrl/api/sliders/getAllSliders';

  // ✅ السلة
  static const String getCart = '$kBaseUrl/cart/getCart';
  static const String addCart = '$kBaseUrl/cart/addToCart';
  static const String removeCart = '$kBaseUrl/cart/removeFromCart';

  // ✅ الطلبات
  static const String getOrders = '$kBaseUrl/api/orders';      // جلب كل الطلبات
  static const String getOrderById = '$kBaseUrl/api/orders/'; // + {orderId}
  static const String addOrder = '$kBaseUrl/api/orders/addOrder'; // إضافة طلب جديد
}
