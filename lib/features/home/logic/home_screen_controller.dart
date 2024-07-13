import 'package:furniture_shopping/core/class/status_request.dart';
import 'package:furniture_shopping/core/constants/routes/AppRoute/routersName.dart';
import 'package:furniture_shopping/core/functions/handlingData.dart';
import 'package:furniture_shopping/features/home/data/home_data.dart';
import 'package:furniture_shopping/features/home/data/models/category_model.dart';
import 'package:furniture_shopping/features/home/data/models/product_model.dart';
import 'package:furniture_shopping/features/home/data/models/slider_model.dart';
import 'package:get/get.dart';

abstract class HomePageController extends GetxController {
  getData();
  getProduct();
}

class HomePageControllerImpl extends HomePageController {
  StatusRequest statusRequest = StatusRequest.none;
  HomeData homeData = HomeData(Get.find());
  List<CategoryModel> categories = [];
  List<ProductModel> products = [];
  List<SliderModel> sliders = [];
  List<ProductModel> getProductsOnSale() {
    return products.where((product) => product.productSalePrice != 0).toList();
  }

  void clearCategories() {
    categories.clear();
  }

  void updateStatus(StatusRequest status) {
    statusRequest = status;
    update();
  }

  int calculateDiscountPercentage(ProductModel product) {
    double discount =
        ((product.productPrice ?? 0) - (product.productSalePrice ?? 0)) /
            (product.productPrice ?? 1) *
            100;
    return discount.round();
  }

  @override
  getData() async {
    statusRequest = StatusRequest.loading;
    update();

    try {
      var response = await homeData.getCategory();
      print("===================================Controller $response");

      statusRequest = handlingData(response);

      if (statusRequest == StatusRequest.success) {
        if (response["status"] == "success") {
        categories.clear();
          List listCat = response["data"]["categories"];
          categories.addAll(listCat.map((e) => CategoryModel.fromJson(e)));
          print("Categories loaded: $categories"); // Debugging line
          update();
        }
      } else if (statusRequest == StatusRequest.offlineFailure) {
        update(); // Display the offline Lottie animation
      } else {
        updateStatus(StatusRequest.failure); // Handle other failure cases
      }
    } catch (e) {
      print("Error loading categories: $e"); // Debugging line
      updateStatus(StatusRequest.failure); // Handle exceptions
    }
  }

  @override
  getProduct() async {
    statusRequest = StatusRequest.loading;
    update();

    try {
      var response = await homeData.getProduct();
      print("===================================Controller $response");

      statusRequest = handlingData(response);

      if (statusRequest == StatusRequest.success) {
        if (response["status"] == "success") {
          // Clear existing products before adding new ones
          products.clear();

          List listProd = response["data"]["products"];
          products.addAll(listProd.map((e) => ProductModel.fromJson(e)));
          update();
        }
      } else if (statusRequest == StatusRequest.offlineFailure) {
        // Display the offline Lottie animation
        update();
      } else {
        // Handle other failure cases
        statusRequest =
            StatusRequest.failure; // or any other appropriate status
      }
    } catch (e) {
      // Handle exceptions if any
      statusRequest = StatusRequest.failure; // or any other appropriate status
    }

    update(); // This updates the UI
  }

  goToProductDetails(productModel) {
    Get.toNamed(AppRouter.productDetails, arguments: {
      "productMode": productModel,
    });
  }

  List<ProductModel> getProductsByCategory(CategoryModel categoryModel) {
    return products
        .where((product) => product.productCategory == categoryModel.id)
        .toList();
  }

  void goToCategoryProducts(CategoryModel selectedCategory) {
    List<ProductModel> categoryProducts =
    getProductsByCategory(selectedCategory);

    Get.toNamed(AppRouter.catScreen, arguments: [categoryProducts]);
  }

  getSlider() async {
    statusRequest = StatusRequest.loading;
    update();

    try {
      var response = await homeData.getSlider();
      print("===================================Controller $response");

      statusRequest = handlingData(response);

      if (statusRequest == StatusRequest.success) {
        if (response["status"] == "success") {
          // Clear existing sliders before adding new ones
          sliders.clear();

          List listProd = response["data"]["sliders"];
          sliders.addAll(listProd.map((e) => SliderModel.fromJson(e)));
          update();
        }
      } else if (statusRequest == StatusRequest.offlineFailure) {
        // Display the offline Lottie animation
        update();
      } else {
        // Handle other failure cases
        statusRequest =
            StatusRequest.failure; // or any other appropriate status
      }
    } catch (e) {
      // Handle exceptions if any
      statusRequest = StatusRequest.failure; // or any other appropriate status
    }

    update(); // This updates the UI
  }

  @override
  void onInit() {
    super.onInit();
    getData();
    getSlider();
    getProduct();
  }
}
