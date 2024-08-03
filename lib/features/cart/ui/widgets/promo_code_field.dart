import 'package:flutter/material.dart';
import 'package:furniture_shopping/features/cart/logic/controllers/cart_controller.dart';

import '../../../../core/class/status_request.dart';

class PromoCodeField extends StatelessWidget {
  final CartController cartController;

  const PromoCodeField({super.key, required this.cartController});

  @override
  Widget build(BuildContext context) {
    TextEditingController promoCode = TextEditingController();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextField(
        controller: promoCode,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.white,
          hintText: 'Enter your promo code',
          suffixIcon: Container(
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(12),
            ),
            child: IconButton(
              icon: Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
              ),
              onPressed: () {
                cartController.applyPromoCode(promoCode.text);
              },
            ),
          ),
        ),
      ),
    );
  }
}
