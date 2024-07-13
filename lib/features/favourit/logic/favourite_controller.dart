import 'package:get/get.dart';
import 'package:furniture_shopping/core/constants/api_link.dart';
import '../../../../core/class/my_services.dart';
import '../../../../core/class/status_request.dart';
import '../../home/data/models/product_model.dart';
import '../data/models/fav_model.dart';
import '../data/services/favourite_services.dart';

class FavouriteController extends GetxController {
  final FavouriteService favouriteService = Get.find();
  RxList<Favorite> favorites = <Favorite>[].obs;
  Rx<StatusRequest> statusRequest = StatusRequest.none.obs;
  MyServices myServices = Get.find();

  @override
  void onInit() {
    super.onInit();
    fetchFavorites();
  }

  Future<void> fetchFavorites() async {
    statusRequest.value = StatusRequest.loading;

    final token = myServices.sharedPreferences.getString('token');
    if (token == null) {
      Get.snackbar('Error', 'User token not found');
      statusRequest.value = StatusRequest.failure;
      return;
    }

    try {
      List<Favorite> fetchedFavorites = await favouriteService.getFavorites(
        AppLink.server,
        token,
      );

      favorites.value = fetchedFavorites;
      statusRequest.value = StatusRequest.success;
    } catch (e) {
      print('Error fetching favorites: $e');
      statusRequest.value = StatusRequest.failure;
      Get.snackbar('Error', 'Failed to fetch favorites');
    }
  }

  Future<void> addToFavorites(String productId) async {
    statusRequest.value = StatusRequest.loading;

    final token = myServices.sharedPreferences.getString('token');
    if (token == null) {
      Get.snackbar('Error', 'User token not found');
      statusRequest.value = StatusRequest.failure;
      return;
    }

    try {
      await favouriteService.addToFavorites(
        AppLink.server,
        productId,
        token,
      );

      await fetchFavorites();
      Get.snackbar('Success', 'Product added to favorites');
      statusRequest.value = StatusRequest.success;
    } catch (e) {
      print('Error adding product to favorites: $e');
      statusRequest.value = StatusRequest.failure;
      Get.snackbar('Error', 'Failed to add product to favorites');
    }
  }

  Future<void> removeFromFavorites(String productId) async {
    statusRequest.value = StatusRequest.loading;

    final token = myServices.sharedPreferences.getString('token');
    if (token == null) {
      Get.snackbar('Error', 'User token not found');
      statusRequest.value = StatusRequest.failure;
      return;
    }

    try {
      await favouriteService.removeFromFavorites(
        productId,
        AppLink.server,
        token,
      );

      await fetchFavorites();
      Get.snackbar('Success', 'Product removed from favorites');
      statusRequest.value = StatusRequest.success;
    } catch (e) {
      print('Error removing product from favorites: $e');
      statusRequest.value = StatusRequest.failure;
      Get.snackbar('Error', 'Failed to remove product from favorites');
    }
  }

  bool isFavorite(String productId) {
    return favorites.any((favorite) => favorite.product.id == productId);
  }

  void toggleFavorite(ProductModel product) async {
    if (isFavorite(product.id!)) {
      await removeFromFavorites(product.id!);
      product.isInFav = false;
    } else {
      await addToFavorites(product.id!);
      product.isInFav = true;
    }
  }
}
