import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/class/status_request.dart';
import '../../logic/controllers/cart_controller.dart';
import 'cart_product_card.dart';

class CartProductsList extends StatelessWidget {
  final CartController cartController;

  const CartProductsList({super.key, required this.cartController});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartController>(
      builder: (controller) {
        switch (controller.statusRequest) {
          case StatusRequest.loading:
            return const Center(child: CircularProgressIndicator());
          case StatusRequest.success:
            if (controller.cart.value.products.isEmpty) {
              return const Center(child: Text('No products in cart'));
            }
            return ListView.builder(
              itemCount: controller.cart.value.products.length,
              itemBuilder: (context, index) {
                final cartItem = controller.cart.value.products[index];
                final product = cartItem.product;

                return product == null
                    ? const ListTile(title: Text('Product not available'))
                    : CartProductCard(cartItem: cartItem, controller: controller);
              },
            );
          default:
            return const Center(child: Text('Failed to load cart'));
        }
      },
    );
  }
}

