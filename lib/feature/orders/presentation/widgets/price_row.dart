import 'package:flutter/material.dart';
import 'package:spex/core/helpers/colors/dark_colors.dart';
import 'package:spex/core/helpers/colors/light_colors.dart';
import 'package:spex/core/helpers/constants/constants.dart';
import 'package:spex/core/widgets/text_in_app_widget.dart';
import 'package:spex/main.dart';

class PriceRow extends StatelessWidget {
  final String label;
  final String value;
  final Color? valueColor;

  const PriceRow({
    super.key,
    required this.label,
    required this.value,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextInAppWidget(
          text: label,
          textSize: 14,
          textColor: isDark
              ? AppColorsDark.appSecondTextColor
              : AppColorsLight.appSecondTextColor,
        ),
        TextInAppWidget(
          text: value,
          textSize: 14,
          fontWeightIndex: FontSelectionData.boldFontFamily,
          textColor:
              valueColor ??
              (isDark ? AppColorsDark.whiteColor : AppColorsLight.appTextColor),
        ),
      ],
    );
  }
}
