import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/class/status_request.dart';
import '../../../../core/constants/api_link.dart';
import '../../../../core/theming/text_styles.dart';
import '../../../cart/logic/controllers/cart_controller.dart';
import '../../logic/favourite_controller.dart';


class FavoritesPage extends StatelessWidget {
  final FavouriteController favouriteController = Get.put(FavouriteController());
  final CartController cartController = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorites'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {},
          ),
        ],
      ),
      body: GetBuilder<FavouriteController>(
        builder: (controller) {
          if (controller.statusRequest == StatusRequest.loading) {
            return Center(child: CircularProgressIndicator());
          }
          if (controller.favorites.isEmpty) {
            return Center(child: Text('No favorites yet'));
          }
          return ListView.builder(
            itemCount: controller.favorites.length,
            itemBuilder: (context, index) {
              final favorite = controller.favorites[index];
              return Card(
                shape: ContinuousRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: CachedNetworkImage(
                            imageUrl: '${AppLink.server}/uploads/products/${favorite.product.productImages!.first}',
                            height: 120,
                            width: 120,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              favorite.product.productName ?? 'Unknown Product',
                              style: TextStyles.font14GrayRegular,
                            ),
                            const SizedBox(height: 10),
                            Text(
                              '\$${favorite.product.productSalePrice}',
                              style: TextStyles.font24BlackBold.copyWith(fontSize: 18),
                            ),
                            const SizedBox(height: 10),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.shopping_bag_outlined),
                            onPressed: () {
                              cartController.addToCart(favorite.product.id!, 1);
                            },
                          ),

                          IconButton(
                            icon: const Icon(Icons.delete_outlined),
                            onPressed: () {
                              favouriteController.removeFromFavorites(favorite.product.id!);
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );

            },
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () {
            for (var favorite in favouriteController.favorites) {
              cartController.addToCart(favorite.product.id!, 1);
            }
          },
          child: Text('Add all to my cart'),
        ),
      ),
    );
  }
}
