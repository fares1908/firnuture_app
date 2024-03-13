import 'package:get/get.dart';

import 'crud.dart';


class initialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(Crud()) ;
  }
}