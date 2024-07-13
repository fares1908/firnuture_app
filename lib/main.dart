import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:furniture_shopping/features/favourit/logic/favourite_controller.dart';
import 'package:get/get.dart';
import 'core/class/initial_binding.dart';
import 'core/class/my_services.dart';
import 'core/constants/routes/AppRoute/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initialServices();

  // Put MyServices into the GetX system
  Get.put(MyServices());


  // Now you can find it
  MyServices myServices = Get.find();
  print(myServices.sharedPreferences.getString('token'));
  print(myServices.sharedPreferences.getString('id'));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      builder: (BuildContext c, child) => GetMaterialApp(
        title: 'Flutter Demo',
        initialBinding: initialBinding(),
        getPages: routes,
        theme: ThemeData(
          useMaterial3: false,
          scaffoldBackgroundColor: Colors.white,
          fontFamily: 'Mulish',
        ),
        debugShowCheckedModeBanner: false,

      ),
    );
  }
}
