import 'package:flutter/material.dart';

class PromoCodeField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Enter your promo code',
          suffixIcon: IconButton(
            icon: const Icon(Icons.arrow_forward),
            onPressed: () {},
          ),
        ),
      ),
    );
  }
}