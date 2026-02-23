import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:spex/core/helpers/colors/dark_colors.dart';
import 'package:spex/core/helpers/colors/light_colors.dart';
import 'package:spex/core/helpers/constants/constants.dart';
import 'package:spex/core/widgets/text_in_app_widget.dart';
import 'package:spex/generated/locale_keys.g.dart';
import 'package:spex/main.dart';

class ApplyedWidget extends StatelessWidget {
  const ApplyedWidget({
    super.key,
    required this.applyedAmount,
    required this.applyedText,
  });
  final double applyedAmount;
  final String applyedText;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isDark
            ? AppColorsDark.appSecondBgColor
            : AppColorsLight.whiteColor,
        borderRadius: BorderRadius.circular(10),
        border: isDark
            ? Border.all(
                color: AppColorsDark.appSecondTextColor.withValues(alpha: 0.3),
              )
            : null,
      ),
      height: 55,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Flexible(
            child: TextInAppWidget(
              text:
                  "${applyedAmount.toStringAsFixed(1)} ${LocaleKeys.cart_sar.tr()}",
              textSize: 14,
              fontWeightIndex: FontSelectionData.regularFontFamily,
              textAlign: TextAlign.center,
              textColor: isDark
                  ? AppColorsDark.whiteColor
                  : AppColorsLight.appTextColor,
              isEllipsisTextOverflow: true,
            ),
          ),
          Expanded(
            flex: 2,
            child: TextInAppWidget(
              text: applyedText.tr(),
              textSize: 12,
              fontWeightIndex: FontSelectionData.regularFontFamily,
              textAlign: TextAlign.center,
              textColor: isDark
                  ? AppColorsDark.appSecondTextColor
                  : AppColorsLight.appSecondTextColor,
              isEllipsisTextOverflow: true,
            ),
          ),
        ],
      ),
    );
  }
}
