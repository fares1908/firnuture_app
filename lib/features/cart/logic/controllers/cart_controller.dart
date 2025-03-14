import 'package:get/get.dart';
import 'package:furniture_shopping/core/constants/api_link.dart';
import '../../../../core/class/my_services.dart';
import '../../../../core/class/status_request.dart';

import '../../data/models/cart_models.dart';

import '../../data/services/cart_services.dart';

class CartController extends GetxController {
  final CartService cartService = Get.find();
  var cart = Cart(products: [], totalPrice: 0.0).obs;
  StatusRequest statusRequest = StatusRequest.none;
  MyServices myServices = Get.find();

  @override
  void onInit() {
    super.onInit();
    fetchCart();
  }

  Future<void> fetchCart() async {
    statusRequest = StatusRequest.loading;
    update();

    try {
      var fetchedCart = await cartService.getCart(
        AppLink.kBaseUrl,
        myServices.sharedPreferences.getString('token')!,
      );
      cart.value = fetchedCart;
      statusRequest = StatusRequest.success;
    } catch (e) {
      print('Error fetching cart: $e');
      statusRequest = StatusRequest.failure;
      Get.snackbar('Error', 'Failed to fetch cart');
    }

    update();
  }

  Future<void> addToCart(String productId, int quantity) async {
    statusRequest = StatusRequest.loading;
    update();

    try {
      await cartService.addToCart(
        AppLink.kBaseUrl,
        productId,
        quantity,
        myServices.sharedPreferences.getString('token')!,
      );
      await fetchCart();
      Get.snackbar('Success', 'Product added to cart');
      statusRequest = StatusRequest.success;
    } catch (e) {
      print('Error adding product to cart: $e');
      statusRequest = StatusRequest.failure;
      Get.snackbar('Error', 'Failed to add product to cart');
    }

    update();
  }
  Future<void> addMultipleToCart(List<String> productIds) async {
    statusRequest = StatusRequest.loading;
    update();

    try {
      await cartService.addMultipleToCart(
        AppLink.kBaseUrl,
        productIds,
        myServices.sharedPreferences.getString('token')!,
      );
      await fetchCart();
      Get.snackbar('Success', 'All products added to cart');
      statusRequest = StatusRequest.success;
    } catch (e) {
      print('Error adding multiple products to cart: $e');
      statusRequest = StatusRequest.failure;
      Get.snackbar('Error', 'Failed to add multiple products to cart');
    }

    update();
  }

  Future<void> removeFromCart(String productId) async {
    statusRequest = StatusRequest.loading;
    update();

    try {
      await cartService.removeFromCart(
        productId,
        AppLink.kBaseUrl,
        myServices.sharedPreferences.getString('token')!,
      );
      await fetchCart();
      Get.snackbar('Success', 'Product removed from cart');
      statusRequest = StatusRequest.success;
    } catch (e) {
      print('Error removing product from cart: $e');
      statusRequest = StatusRequest.failure;
      Get.snackbar('Error', 'Failed to remove product from cart');
    }

    update();
  }

  Future<void> deleteProductFromCart(String productId) async {
    statusRequest = StatusRequest.loading;
    update();

    try {
      await cartService.deleteProductFromCart(
        productId,
        AppLink.kBaseUrl,
        myServices.sharedPreferences.getString('token')!,
      );
      await fetchCart();
      Get.snackbar('Success', 'Product deleted from cart');
      statusRequest = StatusRequest.success;
    } catch (e) {
      print('Error deleting product from cart: $e');
      statusRequest = StatusRequest.failure;
      Get.snackbar('Error', 'Failed to delete product from cart');
    }

    update();
  }

  Future<void> applyPromoCode(String promoCode) async {
    statusRequest = StatusRequest.loading;
    update();
    try {
      await cartService.applyPromoCode(AppLink.kBaseUrl,
          myServices.sharedPreferences.getString('token')!, promoCode);
      Get.snackbar('Success', 'promo code add success');
      statusRequest = StatusRequest.success;
      fetchCart();
    } catch (e) {
      print('Error is : $e');
      statusRequest = StatusRequest.failure;
      Get.snackbar('Error','${e}');
    }

    update();
  }
}
