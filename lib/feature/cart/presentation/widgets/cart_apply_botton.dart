import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:spex/core/helpers/colors/dark_colors.dart';
import 'package:spex/core/helpers/colors/light_colors.dart';
import 'package:spex/core/widgets/text_in_app_widget.dart';
import 'package:spex/generated/locale_keys.g.dart';
import 'package:spex/main.dart';

class CartApplyBotton extends StatelessWidget {
  const CartApplyBotton({
    super.key,
    required this.onPressed,
    required this.isApply,
  });
  final Function() onPressed;
  final bool isApply;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => onPressed(),
      style: ElevatedButton.styleFrom(
        backgroundColor: isApply
            ? (isDark
                  ? AppColorsDark.mainLightColor
                  : AppColorsLight.mainLightColor)
            : (isDark ? AppColorsDark.mainColor : AppColorsLight.mainColor),
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: SizedBox(
        height: 45,
        child: Center(
          child: TextInAppWidget(
            text: isApply
                ? LocaleKeys.cart_cancel.tr()
                : LocaleKeys.cart_apply.tr(),
            textColor: isApply
                ? (isDark ? AppColorsDark.blackColor : AppColorsLight.darkColor)
                : AppColorsLight.whiteColor,
            textSize: 14,
            fontWeightIndex: 700,
          ),
        ),
      ),
    );
  }
}
