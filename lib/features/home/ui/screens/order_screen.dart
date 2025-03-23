import 'package:flutter/material.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
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
        title: const Text('My order', style: TextStyle(color: Colors.black)),
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
        children: [
          OrdersList(status: 'Delivered'),
          OrdersList(status: 'Processing'),
          OrdersList(status: 'Canceled'),
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
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 3, // Replace with real data length
      itemBuilder: (context, index) {
        return OrderCard(
          orderNumber: '238562312',
          date: '20/03/2020',
          quantity: 3,
          total: 150,
          status: status,
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

  const OrderCard({
    super.key,
    required this.orderNumber,
    required this.date,
    required this.quantity,
    required this.total,
    required this.status,
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
              Text("Order No$orderNumber", style: const TextStyle(fontWeight: FontWeight.bold)),
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
                  // Go to order details
                },
                child: const Text("Detail"),
              ),
              Text(
                status,
                style: TextStyle(
                  color: status == 'Delivered'
                      ? Colors.green
                      : status == 'Processing'
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
