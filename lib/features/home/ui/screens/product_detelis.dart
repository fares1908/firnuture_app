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
    // Define a list of classic colors
    List<Color> classicColors = [
      Colors.blue,
      Colors.brown,
      Colors.brown.shade100,
      Colors.grey,
      Colors.black,
      Colors.cyan,
    ];

    // Shuffle the colors and select the first three
    classicColors.shuffle(Random());
    colors = classicColors.take(3).toList();

    // Set the initial selectedColorIndex randomly
    selectedColorIndex = Random().nextInt(colors.length);
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
                  padding: const EdgeInsets.only(left: 18.0),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                    ),
                    child: CarouselSlider(
                      options: CarouselOptions(
                        aspectRatio: 1.0,
                        enlargeCenterPage: true,
                        viewportFraction: 1,
                        autoPlay: true,
                      ),
                      items: widget.product.productImages!.map((imageUrl) {
                        return CachedNetworkImage(
                          height: 500,
                          imageUrl: '${AppLink.server}/uploads/products/$imageUrl',
                          fit: BoxFit.contain,
                          placeholder: (context, url) =>
                          const Center(child: CircularProgressIndicator()),
                          errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                Positioned(
                  top: 10,
                  left: 10,
                  child: IconButton(
                    icon: Container(
                        height: 700,
                        width: 700,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: const Icon(
                          Icons.arrow_back_ios,
                          color: Colors.black,
                          size: 26,
                        )),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                Positioned(
                  left: 10,
                  bottom: 80,
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25),
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
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: colors[index],
                              border: Border.all(
                                color: selectedColorIndex == index
                                    ? Colors.black
                                    : Colors.transparent,
                                width: 2,
                              ),
                            ),
                            child: CircleAvatar(
                              backgroundColor: colors[index],
                              radius: 10,
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                widget.product.productName!,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 24),
              ),
            ),
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                '${widget.product.productDescription}',
                style: const TextStyle(fontSize: 16),
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  FavoriteButton(product: widget.product,),
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
                      child: Text(widget.product.isInCart ?? false
                          ? 'Remove from cart'
                          : 'Add to cart'),
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
