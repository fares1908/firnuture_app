import 'package:furniture_shopping/core/class/my_services.dart';
import 'package:furniture_shopping/core/class/status_request.dart';
import 'package:furniture_shopping/features/home/data/models/product_model.dart';
import 'package:get/get.dart';

class ProductDetailsController extends GetxController {
  late ProductModel productModel;
  StatusRequest statusRequest = StatusRequest.none;

  initialData() async {
    statusRequest = StatusRequest.loading;
    final productModel = Get.arguments?['product'] as ProductModel;
    this.productModel = productModel;
    statusRequest = StatusRequest.success;
    update();
  }

  @override
  void onInit() {
    super.onInit();
    initialData();
  }
}
