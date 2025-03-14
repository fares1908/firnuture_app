import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:furniture_shopping/core/spacing.dart';
import 'package:furniture_shopping/core/theming/colors.dart';
import 'package:furniture_shopping/features/favourit/logic/favourite_controller.dart';
import 'package:get/get.dart';
import '../../../../core/constants/api_link.dart';
import '../../../cart/logic/controllers/cart_controller.dart';
import '../../data/models/product_model.dart';
import '../widgets/favorite_button.dart';

class ProductPage extends StatefulWidget {
  final ProductModel product;

  const ProductPage({super.key, required this.product});

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final CartController cartController = Get.find();
  final FavouriteController favouriteController = Get.find();
  int quantity = 1;
  int selectedColorIndex = 0;
  List<Color> colors = [];

  @override
  void initState() {
    super.initState();
    // استخدام ألوان ثابتة لكل منتج بدلاً من التوزيع العشوائي
    colors = [
      Colors.grey.shade600,
      Colors.brown,
      Colors.brown.shade100,
    ];
    selectedColorIndex = 0; // تحديد اللون الافتراضي
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 40.0 , right: 12, top: 12),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                    ),
                    child: CarouselSlider(

                      options: CarouselOptions(
                        aspectRatio: .75,
                        viewportFraction:1,
                        enlargeCenterPage: true,

                        autoPlay: true,
                      ),
                      items: widget.product.productImages!.map((imageUrl) {
                        return ClipRRect(
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(15)
                          ),
                          child: CachedNetworkImage(
                            width: double.infinity, // ✅ استخدام العرض الكامل
                            fit: BoxFit.cover, // ✅ جعل الصورة تغطي العرض بالكامل
                            imageUrl: '${AppLink.kBaseUrl}/uploads/products/$imageUrl',

                            placeholder: (context, url) =>
                            const Center(child: CircularProgressIndicator()),
                            errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                // زر الرجوع للخلف
                Positioned(
                  top: 20,
                  left: 40,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(10),
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [
                          const BoxShadow(
                            color: Colors.black12,
                            blurRadius: 5,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.black,
                        size: 22,
                      ),
                    ),
                  ),
                ),
                // اختيار اللون
                Positioned(
                  left: 10,
                  top: 120,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: [
                        const BoxShadow(
                          color: Colors.black12,
                          blurRadius: 5,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: Column(
                      children: List.generate(colors.length, (index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedColorIndex = index;
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 4),
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: selectedColorIndex == index
                                    ? Colors.black
                                    : Colors.transparent,
                                width: 2,
                              ),
                            ),
                            child: CircleAvatar(
                              backgroundColor: colors[index],
                              radius: 14,
                              child: selectedColorIndex == index
                                  ? Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 3,
                                  ),
                                ),
                              )
                                  : null,
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // اسم المنتج
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                widget.product.productName!,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 24),
              ),
            ),
            const SizedBox(height:10),
            // المنتج
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                '\$ ${widget.product.productSalePrice}',
                style: const TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 24),
              ),
            ),
            // التقييم
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Icon(Icons.star, color: Colors.amber),
                  SizedBox(width: 5),
                  Text(
                    '4.5',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(width: 5),
                  Text(
                    '(50 reviews)',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            // وصف المنتج
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                widget.product.productDescription!,
                style: const TextStyle(fontSize: 16),
              ),
            ),
            const Spacer(),
            // أزرار المفضلة والإضافة إلى السلة
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  FavoriteButton(product: widget.product),
                  horizontalSpace(10),
                  Expanded(
                    flex: 4,
                    child: ElevatedButton(
                      onPressed: () {
                        if (widget.product.isInCart!) {
                          cartController.deleteProductFromCart(widget.product.id!);
                          setState(() {
                            widget.product.isInCart = false;
                          });
                        } else {
                          cartController.addToCart(widget.product.id!, quantity);
                          setState(() {
                            widget.product.isInCart = true;
                          });
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        widget.product.isInCart ?? false
                            ? 'Remove from cart'
                            : 'Add to cart',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
