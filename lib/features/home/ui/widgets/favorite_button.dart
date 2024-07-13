import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../favourit/logic/favourite_controller.dart';
import '../../data/models/product_model.dart';


class FavoriteButton extends StatelessWidget {
  final ProductModel product;

  FavoriteButton({required this.product});

  @override
  Widget build(BuildContext context) {
    final FavouriteController controller = Get.find();

    return Expanded(
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.grey[300],
        ),
        child: Obx(() {
          return IconButton(
            icon: Icon(
              controller.isFavorite(product.id!)
                  ? Icons.bookmark
                  : Icons.bookmark_border,
            ),
            onPressed: () {
              controller.toggleFavorite(product);
            },
          );
        }),
      ),
    );
  }
}
