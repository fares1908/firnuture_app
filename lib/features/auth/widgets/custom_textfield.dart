import 'package:flutter/material.dart';

import '../../../core/theming/text_styles.dart';


class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {super.key,
      this.controller,
      this.suffixIcon,
      this.onTapIcon,
      this.obscureText = false,
      required this.valid,
      required this.isNumber,
      this.text,});
  final TextEditingController? controller;
  final IconData? suffixIcon;
  final void Function()? onTapIcon;
  final bool? obscureText;
  final String? text;
  final String? Function(String?) valid;
  final bool isNumber;


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      Text
        (
        text!,
        style: TextStyles.font14GrayRegular,

      ),
        TextFormField(
          keyboardType: isNumber == true
              ? const TextInputType.numberWithOptions(decimal: true)
              : TextInputType.text,
          controller: controller,
          validator: valid,
          obscureText: obscureText ?? false,
          cursorColor: Colors.grey,
          decoration:  InputDecoration(
            suffixIcon: InkWell(
              onTap: onTapIcon,
              child: Icon(suffixIcon),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(
                  color: Colors.black), // Change this color
            ),
          ),
        ),
      ],
    );
  }
}
