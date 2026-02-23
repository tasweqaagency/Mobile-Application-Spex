import 'package:flutter/material.dart';
import '../../../../core/helpers/colors/dark_colors.dart';
import '../../../../core/helpers/colors/light_colors.dart';
import '../../../../core/widgets/text_in_app_widget.dart';
import '../../../../main.dart';

class SummaryRowWidget extends StatelessWidget {
  final String label;
  final String value;
  final Color? valueColor;

  const SummaryRowWidget({
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
          fontWeightIndex: 400,
          textColor: isDark
              ? AppColorsDark.appSecondTextColor
              : AppColorsLight.appSecondTextColor,
        ),
        TextInAppWidget(
          text: value,
          textSize: 14,
          fontWeightIndex: 700,
          textColor:
              valueColor ??
              (isDark ? AppColorsDark.whiteColor : AppColorsLight.appTextColor),
        ),
      ],
    );
  }
}
