import 'package:flutter/material.dart';
import 'package:furniture_shopping/core/constants/routes/AppRoute/routersName.dart';
import 'package:furniture_shopping/core/functions/handlingData.dart';
import 'package:get/get.dart';
import '../../../../core/class/my_services.dart';
import '../../../../core/class/status_request.dart';
import '../data/login_data.dart';

abstract class LoginController extends GetxController {
  goToLogin();
}

class LoginControllerImpl extends LoginController {
  late TextEditingController email;
  late TextEditingController password;
  StatusRequest statusRequest = StatusRequest.none;
  MyServices myServices = Get.find();
  LoginData loginData = LoginData(Get.find());
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  IconData showPasswordIcon = Icons.visibility_off_outlined;
  bool isShowPassword = true;

  void toggleShowPassword() {
    isShowPassword = !isShowPassword;
    showPasswordIcon = isShowPassword
        ? Icons.visibility_off_outlined
        : Icons.visibility_outlined;
    update();
  }

  @override
  goToLogin() async {
    if (formState.currentState!.validate()) {
      statusRequest = StatusRequest.loading;
      update();
      try {
        var response = await loginData.loginData(
          email.text,
          password.text,
        );
        print("=============================== Controller $response");
        statusRequest = handlingData(response);
        if (StatusRequest.success == statusRequest) {
          if (response['status'] == 'success') {
            myServices.sharedPreferences
                .setString('id', response['data']['user']['id']);
            myServices.sharedPreferences
                .setString('email', response['data']['user']['email']);
            myServices.sharedPreferences
                .setString('username', response['data']['user']['name']);
            myServices.sharedPreferences
                .setString('token', response['data']['token']);
            print(response['data']['token']);

            Get.offNamed(AppRouter.homeScreen); // Registration success logic
            print("=============================== $statusRequest");
          } else {
            statusRequest = StatusRequest.failure;
          }
        } else {
          Get.snackbar('Error',
              'Registration failed. Please try again or match your password');
        }

        update();
      } catch (e) {
        // Handle any exceptions that may occur during the registration process
        print('Error during registration: $e');
        // Update the statusRequest to indicate failure
        statusRequest = StatusRequest.failure;
        // Update the UI if needed
        update();
      }
    } else {
      Get.snackbar('Waring', 'Enter your information and try again.');
    }
  }

  @override
  @override
  void onInit() {
    print('Controller initialized');
    email = TextEditingController();
    password = TextEditingController();

    super.onInit();
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();

    super.dispose();
  }
}
