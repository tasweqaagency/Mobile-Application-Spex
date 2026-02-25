import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:ui' as ui;

import 'package:spex/core/helpers/colors/light_colors.dart';
import 'package:spex/core/helpers/extentions/extentions.dart';
import 'package:spex/core/helpers/themes/text_styles.dart';
import 'package:spex/core/widgets/text_in_app_widget.dart';
import 'package:spex/core/helpers/constants/constants.dart';
import 'package:spex/core/helpers/colors/dark_colors.dart';
import 'package:spex/main.dart';

class AppTextFormField extends StatefulWidget {
  const AppTextFormField({
    super.key,
    required this.textFormController,
    required this.aboveText,
    required this.keyboardType,
    required this.validator,
    this.onChange,
    this.prefixIcon,
    this.suffixIcon,
    this.hintText,
    this.hintStyle,
    this.errorText,
    this.filledColor,
    this.isPassword = false,
    this.isLTR = false,
    this.isReadOnly = false,
    this.isDigitOnly = false,
    this.verticalPadding,
  });

  final TextEditingController textFormController;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? hintText;
  final TextStyle? hintStyle;
  final String? errorText;
  final bool isPassword;
  final bool isLTR;
  final bool isReadOnly;
  final bool isDigitOnly;
  final String aboveText;
  final TextInputType keyboardType;
  final Function(String?) validator;
  final Function(String?)? onChange;
  final Color? filledColor;
  final double? verticalPadding;

  @override
  State<AppTextFormField> createState() => _AppTextFormFieldState();
}

class _AppTextFormFieldState extends State<AppTextFormField> {
  bool obscureText = true;
  @override
  Widget build(BuildContext context) {
    // final isArabic = context.locale.languageCode == "ar";

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: TextInAppWidget(
            text: widget.aboveText,
            textSize: 15,
            fontWeightIndex: FontSelectionData.semiBoldFontFamily,
            textColor: isDark ? AppColorsDark.whiteColor : Colors.black,
          ),
        ),
        verticalSpace(5),
        widget.isLTR
            ? SizedBox(
                child: Directionality(
                  textDirection: ui.TextDirection.ltr,
                  child: TextFormField(
                    style: TextStyles.font14blackRreg.copyWith(
                      color: isDark
                          ? AppColorsDark.appTextColor
                          : AppColorsLight.appTextColor,
                    ),
                    readOnly: widget.isReadOnly,
                    controller: widget.textFormController,
                    keyboardType: widget.keyboardType,
                    obscureText: widget.isPassword ? obscureText : false,

                    inputFormatters: widget.isDigitOnly
                        ? <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly,
                          ]
                        : null,
                    validator: (value) {
                      return widget.validator(value);
                    },
                    onChanged: (value) {
                      if (widget.onChange != null) {
                        return widget.onChange!(value);
                      }
                    },
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: widget.verticalPadding?.h ?? 16.h,
                      ),
                      fillColor:
                          widget.filledColor ?? AppColorsLight.whiteColor,
                      errorText: widget.errorText,
                      filled: true,

                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(
                          color: isDark
                              ? AppColorsDark.appSecondBgColor
                              : AppColorsLight.appSecondBgColor,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(
                          color: AppColorsLight.mainColor,
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(
                          color: AppColorsLight.mainAccentColor,
                        ),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(
                          color: AppColorsLight.mainAccentColor,
                        ),
                      ),
                      prefixIcon: widget.prefixIcon,
                      suffixIcon: widget.isPassword
                          ? IconButton(
                              onPressed: () {
                                setState(() {
                                  obscureText = !obscureText;
                                });
                              },
                              icon: Icon(
                                !obscureText
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: isDark
                                    ? AppColorsDark.appSecondTextColor
                                    : AppColorsLight.appDarkGrayColor,
                              ),
                            )
                          : widget.suffixIcon,
                      hintText: widget.hintText,
                      hintStyle:
                          widget.hintStyle ??
                          TextStyle(
                            color: isDark
                                ? AppColorsDark.appSecondTextColor
                                : AppColorsLight.appSecondTextColor,
                          ),
                      errorStyle: const TextStyle(
                        color: AppColorsLight.appDarkRedColor,
                      ),
                    ),
                  ),
                ),
              )
            : Container(
                decoration: BoxDecoration(
                  color:
                      widget.filledColor ??
                      (isDark
                          ? AppColorsDark.appSecondBgColor
                          : AppColorsLight.lightGrayColor),
                  borderRadius: BorderRadius.circular(16),
                  //   border: Border.all(
                  //     color: isDark
                  //         ? AppColorsDark.appSecondBgColor
                  //         : AppColorsLight.appGrayColor,
                  //     width: 2,
                  //   ),
                ),
                child: TextFormField(
                  style: TextStyles.font14blackRreg.copyWith(
                    color: isDark ? AppColorsDark.whiteColor : Colors.black,
                  ),
                  readOnly: widget.isReadOnly,
                  inputFormatters: widget.isDigitOnly
                      ? <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly,
                        ]
                      : null,
                  controller: widget.textFormController,
                  keyboardType: widget.keyboardType,
                  obscureText: widget.isPassword ? obscureText : false,
                  onChanged: (value) {
                    if (widget.onChange != null) {
                      return widget.onChange!(value);
                    }
                  },

                  validator: (value) {
                    return widget.validator(value);
                  },
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 10.w,
                      vertical: widget.verticalPadding?.h ?? 16.h,
                    ),
                    fillColor: widget.filledColor ?? AppColorsLight.whiteColor,

                    filled: true,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(
                        color: isDark
                            ? AppColorsDark.appSecondBgColor
                            : AppColorsLight.appSecondBgColor,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(
                        color: AppColorsLight.mainColor,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(
                        color: AppColorsLight.mainAccentColor,
                      ),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(
                        color: AppColorsLight.mainAccentColor,
                      ),
                    ),
                    prefixIcon: widget.prefixIcon,
                    suffixIcon: widget.isPassword
                        ? IconButton(
                            onPressed: () {
                              setState(() {
                                obscureText = !obscureText;
                              });
                            },
                            icon: Icon(
                              !obscureText
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: isDark
                                  ? AppColorsDark.appSecondTextColor
                                  : AppColorsLight.appDarkGrayColor,
                            ),
                          )
                        : widget.suffixIcon,
                    hintText: widget.hintText,
                    hintStyle:
                        widget.hintStyle ??
                        TextStyle(
                          color: isDark
                              ? AppColorsDark.appSecondTextColor
                              : AppColorsLight.appSecondTextColor,
                        ),
                    errorStyle: const TextStyle(
                      color: AppColorsLight.appDarkRedColor,
                    ),
                  ),
                ),
              ),
      ],
    );
  }
}
