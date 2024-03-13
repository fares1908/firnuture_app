import 'package:flutter/material.dart';
import 'package:furniture_shopping/core/constants/routes/AppRoute/routersName.dart';
import 'package:furniture_shopping/core/functions/handlingData.dart';
import 'package:get/get.dart';
import '../../../../core/class/status_request.dart';
import '../data/register_data.dart';

abstract class RegisterController extends GetxController {
  goToRegister();
  goToLogin();
}

class RegisterControllerImpl extends RegisterController {
  late TextEditingController email;
  late TextEditingController password;
  late TextEditingController confirmPassword;
  late TextEditingController name;

  StatusRequest statusRequest = StatusRequest.none;
  RegisterData registerData = RegisterData(Get.find());
  IconData showPasswordIcon = Icons.visibility_off_outlined;
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  @override
  goToLogin() {
    Get.offNamed(AppRouter.loginScreen);
  }
  @override
  goToRegister() async {
    if (formState.currentState!.validate()&&password.text==confirmPassword.text) {
      statusRequest = StatusRequest.loading;
      update();

      try {
        var response = await registerData.registerData(
            email.text, password.text, name.text);

        statusRequest = handlingData(response);

        if (statusRequest == StatusRequest.success) {
          if (response['status'] == 'success') {
            goToLogin();
            print("=============================== $response");
          } else {
            // The server responded with a failure status
            statusRequest = StatusRequest.failure;
            Get.snackbar('Warning', '${response['message']}');
          }
        } else if (statusRequest == StatusRequest.serverFailure) {
          // Handle server failure (status code 500)
          Get.snackbar('Error', 'Internal server error. Please try again later.');
        } else {
          // Handle other error scenarios
          Get.snackbar('Warning', 'An unexpected error occurred');
        }

        update();
      } catch (e) {
        // Handle any exceptions that may occur during the registration process
        print('Error during registration: $e');
        statusRequest = StatusRequest.failure;
        Get.snackbar('Error', 'An error occurred. Please try again later.');
        update();
      }
    } else {
      Get.snackbar('Error', 'Registration failed. Please try again or match your password');
    }
  }



  @override
  void onInit() {
    print('Controller initialized');
    email = TextEditingController();
    password = TextEditingController();
    name = TextEditingController();
    confirmPassword = TextEditingController();

    super.onInit();
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    name.dispose();
    confirmPassword.dispose();

    super.dispose();
  }
}
