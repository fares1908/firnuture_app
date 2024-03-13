import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'fontweight_helper.dart';

class TextStyles {
  static TextStyle font14BlackLight = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeightHelper.light,
    color: Colors.black,
  );
  static TextStyle font24BlackBold = TextStyle(
    fontSize: 30.sp,
    fontWeight: FontWeightHelper.bold,
    color: Colors.black,
  );
  static TextStyle font14GrayRegular = TextStyle(
    fontSize:14.sp,
    fontWeight: FontWeightHelper.regular,
    color: const Color(0xff909090),

  );
  static TextStyle font36BlackExtraBold = TextStyle(
    fontSize: 36.sp,
    fontWeight: FontWeightHelper.extraBold,
    color: Colors.black,
  );

  static TextStyle font30GrayRegular = TextStyle(
    fontSize: 30.sp,
    fontWeight: FontWeightHelper.regular,
    color: const Color(0xff909090),

  );

  static TextStyle font13BlackMedium = TextStyle(
    fontSize: 13.sp,
    fontWeight: FontWeightHelper.medium,
    color: Colors.black,
  );

  static TextStyle font18BlackSemiBold = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeightHelper.semiBold,
    color: Colors.black,
  );
}
