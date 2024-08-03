import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../logic/controllers/cart_controller.dart';

class CartTotal extends StatelessWidget {
  final CartController cartController;

  const CartTotal({super.key, required this.cartController});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0,
      horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Total:',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold,
            color: Colors.grey
            ),
          ),
          Obx(() {
            return Text(
              '\$ ${cartController.cart.value.totalPrice}',
              style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            );
          }),
        ],
      ),
    );
  }
}