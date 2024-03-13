
import 'package:furniture_shopping/core/constants/api_link.dart';

import '../../../../core/class/crud.dart';

class RegisterData{
  Crud crud;
  RegisterData(this.crud);
  registerData(String email, String password, String name,) async {
    try {
      var response = await crud.postData(AppLink.register, {
        "email": email,
        "password": password,
        "name":name
      });
      return response.fold((l) => l, (r) => r);
    } catch (e) {
      print('Error during registration: $e');
      return 'Error during registration: $e';
    }
  }


}