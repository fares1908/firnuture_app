import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButtonNavBar extends StatelessWidget {
  const CustomButtonNavBar({
    super.key,
    this.onPressed,
    required this.iconData,
    this.colorItemSelected,
  });
  final void Function()? onPressed;
  final IconData iconData;
  final Color? colorItemSelected;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      child: Icon(
        iconData,
         size: 23.sp,
        color: colorItemSelected,
      ),
    );
  }
}
