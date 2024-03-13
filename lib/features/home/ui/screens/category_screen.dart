import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:furniture_shopping/core/constants/api_link.dart';
import 'package:furniture_shopping/core/theming/text_styles.dart';
import 'package:furniture_shopping/features/home/data/models/product_model.dart';
import 'package:get/get.dart';

class CategoryProductsScreen extends StatefulWidget {
  const CategoryProductsScreen({Key? key}) : super(key: key);

  @override
  _CategoryProductsScreenState createState() => _CategoryProductsScreenState();
}

class _CategoryProductsScreenState extends State<CategoryProductsScreen> {
  int calculateDiscountPercentage(ProductModel product) {
    double discount =
        ((product.productPrice ?? 0) - (product.productSalePrice ?? 0)) /
            (product.productPrice ?? 1) *
            100;
    return discount.round();
  }

  final List<ProductModel> categoryProducts = Get.arguments?[0] ?? [];
  String selectedSortOption = 'Default';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Products in Category',
          style: TextStyles.font24BlackBold.copyWith(fontSize: 18),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          PopupMenuButton<String>(
            icon: Icon(
              Icons.menu_outlined,
              color: Colors.black,
            ),
            onSelected: (String value) {
              setState(() {
                selectedSortOption = value;
                // Implement your sorting logic here based on the selected option
                // Modify the 'categoryProducts' list accordingly
                // You can add more cases for other sorting options
                switch (selectedSortOption) {
                  case 'Price':
                    categoryProducts.sort((a, b) {
                      // Extract prices after discount, default to 0 if null
                      double priceA = (a.productSalePrice ?? 0).toDouble();
                      double priceB = (b.productSalePrice ?? 0).toDouble();

                      // Fallback to original price if sale price is 0 or null
                      if (priceA == 0) {
                        priceA = (a.productPrice ?? 0).toDouble();
                      }

                      if (priceB == 0) {
                        priceB = (b.productPrice ?? 0).toDouble();
                      }

                      return priceA.compareTo(priceB);
                    });




                    break;
                  case 'AZ':
                    categoryProducts.sort(
                          (a, b) => a.productName!.compareTo(b.productName!),
                    );
                    break;
                  default:
                  // Default case, no sorting
                    break;
                }
              });
            },
            itemBuilder: (BuildContext context) {
              return ['Default', 'Price', 'AZ', 'Add lately']
                  .map((String option) {
                return PopupMenuItem<String>(
                  value: option,
                  child: Text(option),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: ListView(
        children: [
          if (categoryProducts.isEmpty)
            Center(
              // Display a message when there are no products
              child: Text('No products in this category.'),
            )
          else
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
              child: GridView.builder(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                  childAspectRatio: .6,
                ),
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(vertical: 15),
                itemCount: categoryProducts.length,
                itemBuilder: (context, index) {
                  // Display product information
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 2,
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child:CachedNetworkImage(
                                  fit: BoxFit.cover,
                                  imageUrl: '${AppLink.server}/uploads/products/${categoryProducts[index].productImages?.first ?? 'default_image.png'}',
                                  placeholder: (context, url) => const Center(
                                    child: CircularProgressIndicator(
                                      color: Colors.grey,
                                      strokeWidth: 1.5,
                                    ),
                                  ),
                                  errorWidget: (context, url, error) => const Icon(Icons.error),
                                ),


                              ),
                            ),
                            Padding(
                              padding:
                              const EdgeInsets.symmetric(vertical: 5.0),
                              child: Text(
                                '${categoryProducts[index].productName}',
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
                                      categoryProducts[index]
                                          .productSalePrice !=
                                          null &&
                                          categoryProducts[index]
                                              .productSalePrice! >
                                              0
                                          ? '${categoryProducts[index].productSalePrice} EGP'
                                          : '${categoryProducts[index].productPrice} EGP',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyles.font18BlackSemiBold
                                          .copyWith(
                                        fontSize: 13,
                                      ),
                                    ),
                                    if (categoryProducts[index]
                                        .productSalePrice !=
                                        null &&
                                        categoryProducts[index]
                                            .productSalePrice! > 0)
                                      Text(
                                        '${categoryProducts[index].productPrice} EGP',
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
                                if (categoryProducts[index]
                                    .productSalePrice !=
                                    null &&
                                    categoryProducts[index]
                                        .productSalePrice! > 0)
                                  Container(
                                    padding: const EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Text(
                                      '${calculateDiscountPercentage(categoryProducts[index])}% Off',
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
                    onTap: () {},
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
