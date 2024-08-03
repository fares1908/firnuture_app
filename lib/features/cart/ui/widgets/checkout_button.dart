

import 'package:flutter/material.dart';
import 'package:furniture_shopping/features/cart/logic/controllers/cart_controller.dart';

class CheckoutButton extends StatelessWidget {

  const CheckoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(

      onPressed: () {

      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.black,
        minimumSize: const Size(double.infinity, 65),
        textStyle: const TextStyle(fontSize: 18),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: const Text('Check out'),

    );
  }
}