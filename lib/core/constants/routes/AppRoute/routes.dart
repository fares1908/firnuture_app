import 'package:flutter/material.dart';
import 'package:furniture_shopping/features/home/ui/screens/category_screen.dart';
import 'package:furniture_shopping/features/home/ui/screens/home_body.dart';
import 'package:furniture_shopping/features/home/ui/screens/order_details_screen.dart';
import 'package:furniture_shopping/features/home/ui/screens/order_screen.dart';
import 'package:get/get.dart';

import '../../../../features/auth/login/ui/screens/login_screen.dart';
import '../../../../features/auth/sign_up/ui/screens/siginup_screen.dart';
import '../../../../features/cart/ui/view/cart_view.dart';
import '../../../class/my_middel_ware.dart';
import 'routersName.dart';

List<GetPage<dynamic>>? routes = [
  GetPage(
      name: '/', page: () => const LoginScreen(), middlewares: [MyMiddleWare()]),

  GetPage(name: AppRouter.registerScreen, page: () => const SignUpScreen()),
  GetPage(name: AppRouter.loginScreen, page: () => const LoginScreen()),
  GetPage(name: AppRouter.homeScreen, page:() =>const HomeScreenBody()),
  GetPage(name: AppRouter.catScreen, page:() =>const CategoryProductsScreen()),
  GetPage(name: AppRouter.orders, page: () =>  OrdersScreen()),
  GetPage(name: AppRouter.orderDetails, page: () =>  OrderDetailsScreen()),
  // GetPage(name: AppRouter.productDetails, page:() => const ProductDetails()),
  // GetPage(name: AppRouter.popularShoes, page: () => PopularShoes()),
  // GetPage(name: AppRouter.favorite, page: () => const FavouriteScreen()),
  GetPage(name: AppRouter.cart, page: () => CartView()),
  // GetPage(name: AppRouter.checkOut, page: () => CheckOut()),
  // GetPage(name: AppRouter.addressView, page: () => const AddressView()),
  // GetPage(name: AppRouter.addressAdd, page: () =>AddressAdd()),
  //
  // GetPage(name: AppRouter.setting, page: () => const SettingScreen()),
  // GetPage(name: AppRouter.addAddressCart, page: () =>  AddAddressCart()),
  // GetPage(name: AppRouter.orders, page: () =>  OrdersView()),
];
