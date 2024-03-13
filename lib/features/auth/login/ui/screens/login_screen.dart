import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:furniture_shopping/core/constants/routes/AppRoute/routersName.dart';
import 'package:furniture_shopping/core/functions/validation.dart';
import 'package:furniture_shopping/core/spacing.dart';
import 'package:furniture_shopping/core/theming/text_styles.dart';
import 'package:furniture_shopping/features/auth/login/logic/login_controller.dart';
import 'package:furniture_shopping/features/auth/widgets/custom_textfield.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isObscureText = true;
  @override
  Widget build(BuildContext context) {
    Get.put(LoginControllerImpl());
    return Scaffold(
      body: GetBuilder<LoginControllerImpl>(
        builder: (controller) => SingleChildScrollView(
          child: SafeArea(
            child: Form(
              key: controller.formState,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Expanded(
                            child: Divider(
                              color: Colors.grey,
                            )),
                        Expanded(child: SvgPicture.asset('assets/svg/logo.svg')),
                        const Expanded(
                            child: Divider(
                              color: Colors.grey,
                            )),
                      ],
                    ),
                    verticalSpace(16),
                    Text(
                      'Hello !',
                      style: TextStyles.font30GrayRegular,
                    ),
                    Text(
                      'WELCOME BACK',
                      style: TextStyles.font24BlackBold,
                    ),
                    verticalSpace(10),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 1.7,
                      width: double.infinity,
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)
                        ),
                        margin: EdgeInsets.only(top: 30.h),
                        color: Colors.white,
                        elevation: 12,
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              verticalSpace(10),
                              CustomTextField(
                                controller: controller.email,
                                text: 'Enter your email',

                                isNumber: false,
                                valid: (val) {
                                  return validInput(val!, 3, 115, "email");
                                },
                              ),
                              verticalSpace(30),
                              CustomTextField(
                                controller: controller.password,
                                suffixIcon: isObscureText
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                                text: 'Enter your password',
                                obscureText: isObscureText,
                                onTapIcon: () {
                                  setState(() {
                                    isObscureText = !isObscureText;
                                  });
                                },
                                isNumber: false,
                                valid: (val) {
                                  return validInput(val!, 5, 15, "Password");
                                },
                              ),
                              verticalSpace(30),
                              Center(
                                child: Text(
                                  'Forget Password',
                                  style: TextStyles.font18BlackSemiBold,
                                ),
                              ),
                              verticalSpace(30),
                              MaterialButton(
                                minWidth: double.infinity,
                                color: Colors.black,
                                shape: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                onPressed: () {
                                  controller.goToLogin();
                                },
                                height: 50,
                                child: Text(
                                  'LOG IN',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              verticalSpace(10),
                              Center(
                                child: TextButton(
                                  onPressed: () {
                                    Get.toNamed(AppRouter.registerScreen);
                                  },
                                  child: Text(
                                    'SIGN UP',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),

      ),
    );
  }
}
