import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/models/order_model.dart';
import '../../logic/order_controller.dart';

class OrderDetailsScreen extends StatelessWidget {
  const OrderDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final OrderController orderController = Get.find();
    final String orderId = Get.arguments["orderId"];
    orderController.fetchOrderById(orderId);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Details', style: TextStyle(color: Colors.black)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: GetBuilder<OrderController>(
        builder: (controller) {
          if (controller.isOrderLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.selectedOrder == null) {
            return const Center(child: Text("Order not found"));
          }

          OrderModel order = controller.selectedOrder!;
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ✅ معلومات الطلب الأساسية
                _buildOrderInfo(order),
                const SizedBox(height: 16),

                // ✅ قائمة المنتجات داخل الطلب
                const Text("Order Items", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Column(
                  children: order.products.map((product) => _buildProductItem(product)).toList(),
                ),

                const SizedBox(height: 16),

                // ✅ ملخص الطلب
                _buildOrderSummary(order),
              ],
            ),
          );
        },
      ),
    );
  }

  // ✅ معلومات الطلب (رقم الطلب - التاريخ - الحالة)
  Widget _buildOrderInfo(OrderModel order) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Order No: ${order.orderNumber}", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text("Date: ${order.getFormattedDate()}", style: const TextStyle(color: Colors.grey)),
          const SizedBox(height: 8),
          _buildStatusChip(order.status),
        ],
      ),
    );
  }

  // ✅ شريحة حالة الطلب
  Widget _buildStatusChip(String status) {
    Color color = status == "delivered"
        ? Colors.green
        : status == "processing"
        ? Colors.orange
        : Colors.red;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(status.capitalizeFirst!, style: TextStyle(color: color, fontWeight: FontWeight.bold)),
    );
  }

  // ✅ عنصر المنتج في الطلب
  Widget _buildProductItem(ProductOrder product) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          // ✅ صورة المنتج
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              product.image,
              height: 60,
              width: 60,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) =>
              const Icon(Icons.image_not_supported, color: Colors.grey),
            ),
          ),
          const SizedBox(width: 12),

          // ✅ تفاصيل المنتج
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(product.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text("Category: ${product.category}", style: const TextStyle(color: Colors.grey)),
                const SizedBox(height: 4),
                Text("Stock: ${product.stock} pcs", style: TextStyle(color: product.stock > 0 ? Colors.green : Colors.red)),
              ],
            ),
          ),

          // ✅ السعر والكمية
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text("\$${product.price.toStringAsFixed(2)}", style: const TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Text("Qty: ${product.quantity}", style: const TextStyle(color: Colors.grey)),
              const SizedBox(height: 4),
              Text("Subtotal: \$${product.subtotal.toStringAsFixed(2)}",
                  style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.blue)),
            ],
          ),
        ],
      ),
    );
  }

  // ✅ ملخص الطلب
  Widget _buildOrderSummary(OrderModel order) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Order Summary", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Total:", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              Text("\$${order.totalAmount.toStringAsFixed(2)}",
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.green)),
            ],
          ),
        ],
      ),
    );
  }
}
