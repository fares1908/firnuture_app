

import 'package:flutter/material.dart';

class CheckoutButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // Checkout functionality
      },
      child: const Text('Check out'),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
      ),
    );
  }
}