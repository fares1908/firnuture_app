import 'package:flutter/material.dart';
import 'package:otp_timer_button/otp_timer_button.dart';

import '../../../../../core/theming/text_styles.dart';

class CustomAuthResendCode extends StatelessWidget {
  const CustomAuthResendCode(
      {super.key,
      required this.text,
      required this.textButton,
      this.onPressed});
  final String text;
  final String textButton;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          text,
          style: TextStyles.font13BlackMedium,
        ),
        OtpTimerButton(
            buttonType: ButtonType.text_button,
            onPressed: onPressed,

            // textColor: ,
            text: Text(

              textButton,
              style: TextStyles.font13BlackMedium.copyWith(color: Colors.blue),
            ),
            duration: 30)
      ],
    );
  }
}
