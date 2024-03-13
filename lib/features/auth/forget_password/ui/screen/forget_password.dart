// import 'dart:ui' as ui;
//
// import 'package:flutter/material.dart';
// import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import '../../../../../core/theming/colors.dart';
// import '../../../../../core/spacing.dart';
// import '../../../../../core/theming/text_styles.dart';
// import '../../../widgets/custom_matrialbutton.dart';
// import '../widgets/custom_auth_resendCode.dart';
//
// class ForgetPassword extends StatelessWidget {
//   const ForgetPassword({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Stack(
//               alignment: Alignment.centerRight,
//               children: [
//
//                 SizedBox(
//                   height: 340.h,
//                   width: double.infinity,
//                   child: SvgPicture.asset(
//                     'assets/svg/verfiy_shap.svg',
//                     fit: BoxFit.fill,
//                   ),
//                 ),
//                  Padding(
//                    padding:  EdgeInsets.only(right: 12.w),
//                    child: SvgPicture.asset('assets/svg/logo.svg'),
//                  ) ,
//               ],
//             ),
//             Padding(
//               padding:
//                EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 10.h),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text('Almost there ', style: TextStyles.font36BlackExtraBold),
//                   //verticalSpace(10),
//
//                   RichText(
//                     text: TextSpan(
//                       text:
//                           'Please enter the 6-digit code sent to your  email ',
//                       style: TextStyles.font14BlackLight.copyWith(height: 1.2),
//                       children: <TextSpan>[
//                         TextSpan(
//                           text: 'contact.uiuxexperts@gmail.com',
//                           style: TextStyles.font14SemiBold
//                               .copyWith(color: AppColors.minColor),
//                         ),
//                         TextSpan(
//                           text: ' for verification.',
//                           style:
//                               TextStyles.font14BlackLight.copyWith(height: 1.2),
//                         ),
//                       ],
//                     ),
//                   ),
//
//                   verticalSpace(20),
//                   OtpTextField(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     numberOfFields: 5,
//                     borderRadius: BorderRadius.circular(13),
//                     borderColor: Colors.grey,
//                     focusedBorderColor: Colors.grey,
//                     fillColor: Colors.grey,
//                     cursorColor: Colors.grey,
//                     //set to true to show as box or false to show as dash
//                     showFieldAsBox: true,
//                     //runs when a code is typed in
//                     onCodeChanged: (String code) {
//                       //handle validation or checks here
//                     },
//                     //runs when every textfield is filled
//                     onSubmit: (String verificationCode) {
//                       showDialog(
//                           context: context,
//                           builder: (context) {
//                             return AlertDialog(
//                               title: Text("Verification Code"),
//                               content:
//                                   Text('Code entered is $verificationCode'),
//                             );
//                           });
//                     }, // end onSubmit
//                   ),
//                   verticalSpace(25),
//                   CustomButtonAuth(
//                     textButton: 'Verify',
//                     onPressed: () {},
//                   ),
//                   verticalSpace(25),
//
//                   CustomAuthResendCode(
//                     text: 'Didn’t receive any code?',
//                     textButton: 'Resend Code',
//                     onPressed: () {},
//                   )
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
