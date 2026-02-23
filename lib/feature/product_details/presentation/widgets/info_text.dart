import 'package:flutter/material.dart';
import '../../../../core/helpers/colors/dark_colors.dart';
import '../../../../core/helpers/colors/light_colors.dart';
import '../../../../core/widgets/text_in_app_widget.dart';
import '../../../../core/helpers/constants/constants.dart';
import '../../../../main.dart';

class InfoText extends StatelessWidget {
  final String text;

  const InfoText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return TextInAppWidget(
      text: text,
      textSize: 13,
      fontWeightIndex: FontSelectionData.regularFontFamily,
      textColor: isDark
          ? AppColorsDark.appSecondTextColor
          : AppColorsLight.appSecondTextColor.withValues(alpha: 0.8),
    );
  }
}
