import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../colors/light_colors.dart';

class TextStyles {
  static TextStyle font13whiteBold = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 13.sp,
  );
  static TextStyle font10whiteBold = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 10.sp,
  );
  static TextStyle font12whiteBold = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 12.sp,
  );
  // static TextStyle font12whiteBold = TextStyle(fontWeight: FontWeight.bold,fontSize: 12.sp);
  static TextStyle font14whiteBold = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 14.sp,
  );
  static TextStyle font18whiteBold = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 18.sp,
  );

  static TextStyle font14blackRreg = const TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 14,
    // fontFamily: "LamaSans",
    color: AppColorsLight.blackColor,
  );

  static TextStyle font15blackSemiBold = const TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 15,
    // fontFamily: "LamaSans",
    color: AppColorsLight.blackColor,
  );

  static TextStyle font13mainColorBold = TextStyle(
    fontSize: 13.sp,
    fontWeight: FontWeight.bold,
    color: AppColorsLight.mainColor,
  );
  static TextStyle font15mainColorBold = TextStyle(
    fontSize: 15.sp,
    fontWeight: FontWeight.bold,
    color: AppColorsLight.mainColor,
  );
  static TextStyle font10mainColorBold = TextStyle(
    fontSize: 10.sp,
    fontWeight: FontWeight.bold,
    color: AppColorsLight.mainColor,
  );
  static TextStyle font25mainColorBold = TextStyle(
    fontSize: 25.sp,
    fontWeight: FontWeight.bold,
    color: AppColorsLight.mainColor,
  );

  static TextStyle font25WhiteColorBold = TextStyle(
    fontSize: 25.sp,
    fontWeight: FontWeight.bold,
    color: AppColorsLight.whiteColor,
  );
}
