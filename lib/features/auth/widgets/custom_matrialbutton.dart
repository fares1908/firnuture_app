// import 'package:flutter/material.dart';
//
// import '../../../core/theming/colors.dart';
// import '../../../core/spacing.dart';
// import '../../../core/theming/text_styles.dart';
//
// class CustomButtonAuth extends StatelessWidget {
//   const CustomButtonAuth({
//     super.key,
//     required this.textButton,
//     this.onPressed,
//     this.icon, // New optional parameter for the icon
//   });
//
//   final String textButton;
//   final void Function()? onPressed;
//   final IconData? icon; // IconData type for the icon
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         color: AppColors.themeColor,
//         borderRadius: BorderRadius.circular(16),
//       ),
//       child: Center(
//         child: MaterialButton(
//           shape: OutlineInputBorder(
//             borderSide: const BorderSide(
//               color: AppColors.themeColor,
//             ),
//             borderRadius: BorderRadius.circular(16),
//           ),
//           height: 50,
//           minWidth: MediaQuery.of(context).size.width * 0.9,
//           onPressed: onPressed,
//           child: Row(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text(
//                 textButton,
//                 style: TextStyles.font1BlackSemiBold,
//               ),
//               horizontalSpace(12),
//               if (icon != null) // Conditionally display the icon if provided
//                 Icon(
//                   icon,
//                   color: Colors.white,
//                   size: 18,
//                 ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
