import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../logic/controllers/cart_controller.dart';
import '../widgets/cart_products_list.dart';
import '../widgets/cart_totale.dart';
import '../widgets/checkout_button.dart';
import '../widgets/promo_code_field.dart';

class CartView extends StatelessWidget {
  final CartController cartController = Get.put(CartController());

  CartView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              size: 24,
              color: Colors.black,
            )),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'My cart',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Expanded(child: CartProductsList(cartController: cartController)),
            PromoCodeField(cartController: cartController,),
            CartTotal(cartController: cartController),
             CheckoutButton(),
          ],
        ),
      ),
    );
  }
}
