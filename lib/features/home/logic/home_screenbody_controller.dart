import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

import 'package:furniture_shopping/features/home/ui/screens/home_screen.dart';
import 'package:furniture_shopping/features/notifcation/notifcaion.dart';
import 'package:furniture_shopping/features/user/user_screen.dart';
import 'package:get/get.dart';

import '../../cart/ui/view/cart_view.dart';
import '../../favourit/ui/view/favourite_screen.dart';

abstract class HomeScreenBodyController extends GetxController {
  changePage(int index);
}

class HomeScreenBodyControllerImpl extends HomeScreenBodyController {
  int currentPage = 0;
  List<Widget> listPage = [
    const HomeScreen(),
    FavoritesPage(),
    const NotficationScreen(),
    const UserScreen()
    //
    // const UserScreen(),
  ];

  List<IconData> iconButton = [
    IconlyLight.home,
    IconlyLight.bookmark,
    IconlyLight.notification,
    IconlyLight.profile,
  ];

  @override
  changePage(int index) {
    currentPage = index;
    update();
  }
}
