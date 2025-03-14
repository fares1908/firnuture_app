import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:furniture_shopping/core/widget/custom_button.dart';
import 'package:get/get.dart';
import '../../../../core/class/status_request.dart';
import '../../../../core/constants/api_link.dart';
import '../../../../core/theming/text_styles.dart';
import '../../../cart/logic/controllers/cart_controller.dart';
import '../../logic/favourite_controller.dart';

class FavoritesPage extends StatelessWidget {
  final FavouriteController favouriteController =
      Get.put(FavouriteController());
  final CartController cartController = Get.put(CartController());

  FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.search,
            color: Colors.black,
          ),
          onPressed: () {},
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Favorites',
          style: TextStyles.font18BlackSemiBold,
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.shopping_cart_outlined,
              color: Colors.black,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: GetBuilder<FavouriteController>(
        builder: (controller) {
          if (controller.statusRequest == StatusRequest.loading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (controller.favorites.isEmpty) {
            return const Center(child: Text('No favorites yet'));
          }
          return ListView.separated(
            itemCount: controller.favorites.length,
            itemBuilder: (context, index) {
              final favorite = controller.favorites[index];
              return Card(
                elevation: 0,
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
                            imageUrl:
                                '${AppLink.kBaseUrl}/uploads/products/${favorite.product.productImages!.first}',
                            height: 100,
                            width: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            favorite.product.productName ?? 'Unknown Product',
                            style: TextStyles.font14GrayRegular
                                .copyWith(color: const Color(0xff606060)),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            '\$ ${favorite.product.productSalePrice}',
                            style: TextStyles.font24BlackBold
                                .copyWith(fontSize: 18),
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
                      const Spacer(),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // زر الحذف (إكس داخل دائرة)
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.black, width: 2),
                            ),
                            child: InkWell(
                                onTap: () {
                                  favouriteController.removeFromFavorites(
                                      favorite.product.id!);
                                },
                                child: const Icon(Icons.close,
                                    size: 20, color: Colors.black)),
                          ),

                          const SizedBox(height: 30),

                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.05),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: InkWell(
                                onTap: () {
                                  cartController.addToCart(
                                      favorite.product.id!, 1);
                                },
                                child: const Icon(Icons.shopping_bag_outlined,
                                    size: 30, color: Colors.black)),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) => const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Divider(
                color: Color(0xffF0F0F0),
                height: 2,
                thickness: 2,
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: CustomButton(
          onPressed: () {
            List<String> productIds = favouriteController.favorites
                .map((fav) => fav.product.id!)
                .toList();
            cartController.addMultipleToCart(productIds);
          },
          text: 'Add all to my cart',
        ),
      ),
    );
  }
}
