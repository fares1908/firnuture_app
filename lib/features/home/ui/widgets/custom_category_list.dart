import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:furniture_shopping/core/constants/api_link.dart';
import 'package:furniture_shopping/core/spacing.dart';
import 'package:furniture_shopping/core/theming/text_styles.dart';
import 'package:furniture_shopping/features/home/logic/home_screen_controller.dart';
import 'package:get/get.dart';

class CustomCategoryList extends GetView<HomePageControllerImpl> {
  const CustomCategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 85.h,
      child: ListView.separated(
        separatorBuilder: (context, index) => horizontalSpace(8),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => GestureDetector(
          onTap: () {
            controller.goToCategoryProducts(controller.categories[index]);
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                height: 48.h,
                width: 48.w,
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(.4),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: CachedNetworkImage(
                  imageUrl:
                      '${AppLink.server}/uploads/categories/${controller.categories[index].categoryImage}',
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      CircularProgressIndicator(
                          value: downloadProgress.progress),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
              verticalSpace(5),
              Text(
                '${controller.categories[index].categoryName}',
                style: TextStyles.font14GrayRegular,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ],
          ),
        ),
        itemCount: controller.categories.length,
      ),
    );
  }
}
