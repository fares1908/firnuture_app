import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:furniture_shopping/core/class/handling_data_view.dart';
import 'package:furniture_shopping/core/theming/text_styles.dart';
import 'package:furniture_shopping/features/home/logic/home_screen_controller.dart';
import 'package:furniture_shopping/features/home/ui/widgets/custom_category_list.dart';
import 'package:furniture_shopping/features/home/ui/widgets/custom_gridview_list.dart';
import 'package:get/get.dart';

import '../../../../core/constants/api_link.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(HomePageControllerImpl());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: IconButton(
            onPressed: () {},
            icon: const Icon(
              IconlyLight.search,
              color: Colors.grey,
            ),
          ),
        ),
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(
                'Make home',
                style: TextStyles.font30GrayRegular.copyWith(fontSize: 18.sp),
              ),
              Text(
                'BEAUTIFUL',
                style: TextStyles.font24BlackBold.copyWith(fontSize: 21.sp),
              ),
            ],
          ),
        ),
        actions: [
          badges.Badge(
            position: badges.BadgePosition.topEnd(top: 10, end: 10),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                icon: const Icon(
                  Icons.shopping_cart_outlined,
                  color: Colors.grey,
                  size: 30,
                ),
                onPressed: () {},
              ),
            ),
          ),
        ],
      ),
      body: GetBuilder<HomePageControllerImpl>(
          builder: (controller) => HandlingDataView(
                statusRequest: controller.statusRequest,
                widget: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                  child: ListView(
                    children: [
                      const Divider(
                        thickness: 2,
                      ),
                      CarouselSlider(
                        options: CarouselOptions(
                          autoPlay: true,
                          autoPlayAnimationDuration: Duration(milliseconds: 100),
                          autoPlayCurve: Curves.easeIn,
                         enableInfiniteScroll: true,
                          aspectRatio: 2.0,
                          enlargeCenterPage: true,
                        ),
                        items: controller.sliders.map((slider) {
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.symmetric(horizontal: 5.0),
                            decoration: BoxDecoration(
                              // Use CachedNetworkImageProvider inside DecorationImage
                              image: DecorationImage(
                                image: CachedNetworkImageProvider(
                                  '${AppLink.server}/uploads/sliders/${slider.sliderImage}',
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: CachedNetworkImage(
                              imageUrl: '${AppLink.server}/uploads/sliders/${slider.sliderImage}',
                              progressIndicatorBuilder: (context, url, downloadProgress) {
                                return Center(
                                  child: CircularProgressIndicator(
                                    value: downloadProgress.progress,
                                  ),
                                );
                              },
                              errorWidget: (context, url, error) => const Icon(Icons.error),
                            ),
                          );

                        }).toList(),
                      ),
                      const Divider(
                        thickness: 2,
                      ),
                      const CustomCategoryList(),
                      const Divider(
                        thickness: 2,
                      ),
                      Text('Special offer', style: TextStyles.font24BlackBold),
                      const CustomGridView(),
                    ],
                  ),
                ),
              )),
    );
  }
}
