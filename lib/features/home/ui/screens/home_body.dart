import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:furniture_shopping/features/home/logic/home_screenbody_controller.dart';
import 'package:furniture_shopping/features/home/ui/widgets/CustomButtonAppBarHome.dart';
import 'package:get/get.dart';

class HomeScreenBody extends StatelessWidget {
  const HomeScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(HomeScreenBodyControllerImpl());

    return GetBuilder<HomeScreenBodyControllerImpl>(
      builder: (controller) {
        return Scaffold(
            backgroundColor: Colors.grey[100],
            bottomNavigationBar: const CustomButtonAppBarHome(),

            body: controller.listPage.elementAt(controller.currentPage));
      },
    );
  }
}
