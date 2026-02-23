import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:spex/core/helpers/colors/light_colors.dart';
import 'package:spex/core/widgets/text_in_app_widget.dart';

class AppTextButton extends StatelessWidget {
  final double? borderRadius;
  final Color? backgroundColor;
  final double? horizontalPadding;
  final double? verticalPadding;
  final double? buttonWidth;
  final double? buttonHeight;
  final String buttonText;
  final TextStyle textStyle;
  final VoidCallback onPressed;
  const AppTextButton({
    super.key,
    this.borderRadius,
    this.backgroundColor,
    this.horizontalPadding,
    this.verticalPadding,
    this.buttonHeight,
    this.buttonWidth,
    required this.buttonText,
    required this.textStyle,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 16.0),
          ),
        ),
        backgroundColor: WidgetStateProperty.all(
          backgroundColor ?? AppColorsLight.mainColor,
        ),
        // padding: WidgetStateProperty.all<EdgeInsets>(
        //   EdgeInsets.symmetric(
        //     horizontal: horizontalPadding?.w ?? 12.w,
        //     vertical: verticalPadding?.h ?? 14.h,
        //   ),
        // ),
        fixedSize: WidgetStateProperty.all(
          Size(buttonWidth?.w ?? double.maxFinite, buttonHeight ?? 43.h),
        ),
      ),
      onPressed: onPressed,
      child: TextInAppWidget(
        text: buttonText,
        textColor: textStyle.color,
        textSize: textStyle.fontSize,
        textAlign: TextAlign.center,
        fontWeightIndex: textStyle.fontWeight == FontWeight.bold ? 700 : 400,
      ),
    );
  }
}
