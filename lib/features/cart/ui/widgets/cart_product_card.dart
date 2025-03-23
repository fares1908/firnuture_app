import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../../core/constants/api_link.dart';
import '../../../../core/theming/text_styles.dart';
import '../../data/models/cart_models.dart';
import '../../logic/controllers/cart_controller.dart';

class CartProductCard extends StatelessWidget {
  final CartItem cartItem;
  final CartController controller;

  const CartProductCard(
      {super.key, required this.cartItem, required this.controller});

  @override
  Widget build(BuildContext context) {
    final product = cartItem.product!;
    return Card(
      elevation: 0,
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: CachedNetworkImage(
              imageUrl:
                  '${AppLink.kBaseUrl}/uploads/products/${product.productImages!.first}',
              height: 100,
              width: 100,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      product.productName ?? 'Unknown Product',
                      style: TextStyles.font14GrayRegular,
                    ),
                    const SizedBox(width: 10),
                    Container(
                      // margin: EdgeInsets.all(value),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.black, width: 2),
                      ),
                      child: InkWell(
                          onTap: () {
                            controller.deleteProductFromCart(cartItem.product!.id!);
                          },
                          child: const Icon(Icons.close,
                              size: 15, color: Colors.black)),
                    ),

                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  '\$ ${product.productSalePrice}',
                  style: TextStyles.font24BlackBold.copyWith(fontSize: 18),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    children: [
                      Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(.2),
                          borderRadius: BorderRadius.circular(6)
                        ),
                       
                        child: IconButton(
                          icon: const Icon(
                            Icons.remove,
                            size: 14,
                          ),
                          onPressed: () {
                            if (cartItem.quantity > 1) {
                              controller.addToCart(cartItem.product!.id!, -1);
                            } else {
                              controller.removeFromCart(cartItem.product!.id!);
                            }
                          },
                        ),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        cartItem.quantity.toString().padLeft(2, '0'),
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(width: 5),
                      Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(.2),
                            borderRadius: BorderRadius.circular(6)
                        ),

                        child: IconButton(
                          icon: const Icon(
                            Icons.add,
                            size: 14,
                          ),
                          onPressed: () {
                            controller.addToCart(cartItem.product!.id!, 1);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
