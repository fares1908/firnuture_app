import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/theming/text_styles.dart';

class CustomAuthRow extends StatelessWidget {
  const CustomAuthRow({super.key, required this.text, required this.textButton, this.onPressed});
  final String text;
  final String textButton;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return   Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          text,
          style: TextStyles.font13BlackMedium,
        ),
        TextButton(
          onPressed:onPressed,
          child: Text(
            textButton,
            style: TextStyles.font13BlackMedium.copyWith(color: Colors.blue),
          ),
        ),
      ],
    );
  }
}
