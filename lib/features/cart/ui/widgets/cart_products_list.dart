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
        if (controller.cart.value.products.isEmpty) {
          return const Center(child: Text('No products in cart'));
        }
        return ListView.separated(
          separatorBuilder: (context, index) => Divider(
            thickness: 1,
            color: Colors.grey.withOpacity(.2),
          ),
          itemCount: controller.cart.value.products.length,
          itemBuilder: (context, index) {
            final cartItem = controller.cart.value.products[index];
            final product = cartItem.product;

            return product == null
                ? const ListTile(title: Text('Product not available'))
                : CartProductCard(cartItem: cartItem, controller: controller);
          },
        );
      },
    );
  }
}
