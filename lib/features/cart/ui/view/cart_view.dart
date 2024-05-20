import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/class/status_request.dart';
import '../../../../core/constants/api_link.dart';
import '../../data/models/cart_models.dart';
import '../../logic/controllers/cart_controller.dart';
import '../widgets/cart_products_list.dart';
import '../widgets/cart_totale.dart';
import '../widgets/checkout_button.dart';
import '../widgets/promo_code_field.dart';

class CartView extends StatelessWidget {
  final CartController cartController = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My cart'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(child: CartProductsList(cartController: cartController)),
            PromoCodeField(),
            CartTotal(cartController: cartController),
            CheckoutButton(),
          ],
        ),
      ),
    );
  }
}








