import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:furniture_shopping/core/constants/api_link.dart';
import 'package:furniture_shopping/core/theming/text_styles.dart';
import 'package:furniture_shopping/features/home/data/models/product_model.dart';
import 'package:furniture_shopping/features/home/logic/home_screen_controller.dart';
import 'package:get/get.dart';

import '../screens/product_detelis.dart';

class CustomGridView extends GetView<HomePageControllerImpl> {
  const CustomGridView({super.key});

  @override
  Widget build(BuildContext context) {
    return StaggeredGridView.countBuilder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(vertical: 15),
      crossAxisCount: 2,
      crossAxisSpacing: 10.0,
      mainAxisSpacing: 10.0,
      itemCount: controller.getProductsOnSale().length,
      staggeredTileBuilder: (index) {
        return StaggeredTile.count(1, index.isEven ? 1.8 : 1.4);
      },
      itemBuilder: (context, index) {
        ProductModel product = controller.getProductsOnSale()[index];
        return InkWell(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.grey.withOpacity(.4),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        imageUrl:
                        '${AppLink.server}/uploads/products/${product.productImages?.first}',
                        placeholder: (context, url) => const Center(
                          child: CircularProgressIndicator(
                            color: Colors.grey,
                            strokeWidth: 1.5,
                          ),
                        ),
                        errorWidget: (context, url, error) =>
                        const Icon(
                          Icons.error,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                    const EdgeInsets.symmetric(vertical: 5.0),
                    child: Text(
                      '${product.productName}',
                      style: TextStyles.font30GrayRegular.copyWith(
                        fontSize: 18,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.productSalePrice != null &&
                                product.productSalePrice! > 0
                                ? '${product.productSalePrice} EGP'
                                : '${product.productPrice} EGP',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyles.font18BlackSemiBold
                                .copyWith(
                              fontSize: 13,
                            ),
                          ),
                          if (product.productSalePrice != null &&
                              product.productSalePrice! > 0)
                            Text(
                              '${product.productPrice} EGP',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                                decoration:
                                TextDecoration.lineThrough,
                              ),
                            ),
                        ],
                      ),
                      if (product.productSalePrice != null &&
                          product.productSalePrice! > 0)
                        Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            '${controller.calculateDiscountPercentage(product)}% Off',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          onTap: () {
           Get.to(ProductPage(product: product,),
           );
          },
        );
      },
    );
  }
}
