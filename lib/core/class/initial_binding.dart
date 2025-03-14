import 'package:get/get.dart';
import '../../features/cart/data/services/cart_services.dart';
import '../../features/favourit/data/services/favourite_services.dart';
import '../constants/api_link.dart';
import 'crud.dart';
import 'dio_client.dart';

class initialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(Crud());

    // ✅ إنشاء DioClient أولاً وتمريره لـ CartService و FavouriteService
    final DioClient dioClient = Get.put(DioClient(AppLink.kBaseUrl, null));

    Get.put(CartService());  // ✅ تمرير dioClient عند حقن CartService
    Get.put(FavouriteService());  // ✅ تمرير dioClient عند حقن FavouriteService
  }
}
