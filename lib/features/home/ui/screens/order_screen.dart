import 'package:flutter/material.dart';
import 'package:furniture_shopping/core/constants/routes/AppRoute/routersName.dart';
import 'package:get/get.dart';
import '../../../../core/class/status_request.dart';
import '../../data/models/order_model.dart';
import '../../logic/order_controller.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> with SingleTickerProviderStateMixin {
  late TabController tabController;
  final OrderController orderController = Get.put(OrderController(), permanent: true); // ✅ اجعل الـ Controller دائمًا في الذاكرة

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);

    // ✅ لو الطلبات فاضية فقط، اعمل جلب للبيانات
    if (orderController.orders.isEmpty) {
      orderController.getOrders();
    }
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Orders', style: TextStyle(color: Colors.black)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        bottom: TabBar(
          controller: tabController,
          labelColor: Colors.black,
          unselectedLabelColor: Colors.grey,
          indicatorColor: Colors.black,
          tabs: const [
            Tab(text: 'Delivered'),
            Tab(text: 'Processing'),
            Tab(text: 'Canceled'),
          ],
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: const [
          OrdersList(status: 'delivered'),
          OrdersList(status: 'processing'),
          OrdersList(status: 'canceled'),
        ],
      ),
    );
  }
}

class OrdersList extends StatelessWidget {
  final String status;

  const OrdersList({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderController>(
      builder: (controller) {
        if (controller.isLoading.isTrue) {
          return const Center(child: CircularProgressIndicator());
        }

        List<OrderModel> filteredOrders = controller.orders
            .where((order) => order.status.toLowerCase() == status.toLowerCase())
            .toList();

        if (filteredOrders.isEmpty) {
          return const Center(child: Text("No orders found"));
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: filteredOrders.length,
          itemBuilder: (context, index) {
            var order = filteredOrders[index];

            return OrderCard(
              orderNumber: order.id.substring(0, 8),
              date: order.getFormattedDate(),
              quantity: order.products.fold(0, (sum, item) => sum + item.quantity),
              total: order.totalAmount,
              status: order.status,
              orderId: order.id, // ✅ تمرير رقم الطلب عشان نروح للـ Order Details
            );
          },
        );
      },
    );
  }
}

class OrderCard extends StatelessWidget {
  final String orderNumber;
  final String date;
  final int quantity;
  final double total;
  final String status;
  final String orderId;

  const OrderCard({
    super.key,
    required this.orderNumber,
    required this.date,
    required this.quantity,
    required this.total,
    required this.status,
    required this.orderId,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Order No $orderNumber", style: const TextStyle(fontWeight: FontWeight.bold)),
              Text(date, style: const TextStyle(color: Colors.grey)),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Quantity: ${quantity.toString().padLeft(2, '0')}",
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              Text("Total Amount: \$${total.toStringAsFixed(0)}",
                  style: const TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                ),
                onPressed: () {
                  // ✅ التنقل إلى تفاصيل الطلب مع تمرير `orderId`
                  Get.toNamed(AppRouter.orderDetails, arguments: {"orderId": orderId});
                },
                child: const Text("Detail"),
              ),
              Text(
                status.capitalizeFirst!,
                style: TextStyle(
                  color: status == 'delivered'
                      ? Colors.green
                      : status == 'processing'
                      ? Colors.orange
                      : Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
