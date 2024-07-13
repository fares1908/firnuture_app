import 'package:get/get.dart';

import '../../features/cart/data/services/cart_services.dart';
import '../../features/favourit/data/services/favourite_services.dart';
import 'crud.dart';


class initialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(Crud()) ;
    Get.put(CartService());
    Get.put(FavouriteService());
  }
}