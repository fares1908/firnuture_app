import 'package:get/get.dart';
import '../data/models/order_model.dart';
import '../data/order_data.dart';


class OrderController extends GetxController {
  OrderService orderService = Get.find();
  List<OrderModel> orders = [];
  OrderModel? selectedOrder;
  var isLoading = true.obs;
  var isOrderLoading = false.obs;

  // ✅ جلب كل الطلبات
  Future<void> getOrders() async {
    isLoading.value = true;
    try {
      orders = await orderService.getOrders();
    } catch (e) {
      print("❌ Error fetching orders: $e");
    } finally {
      isLoading.value = false;
      update();
    }
  }

  // ✅ جلب طلب معين
  Future<void> fetchOrderById(String orderId) async {
    isOrderLoading.value = true;
    try {
      selectedOrder = await orderService.getOrderById(orderId);
    } catch (e) {
      selectedOrder = null;
      print("❌ Error fetching order: $e");
    } finally {
      isOrderLoading.value = false;
      update();
    }
  }

  @override
  void onInit() {
    super.onInit();
    getOrders();
  }
}
