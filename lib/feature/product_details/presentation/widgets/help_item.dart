import 'package:flutter/material.dart';
import '../../../../core/helpers/colors/dark_colors.dart';
import '../../../../core/helpers/colors/light_colors.dart';
import '../../../../core/widgets/text_in_app_widget.dart';
import '../../../../core/helpers/constants/constants.dart';
import '../../../../main.dart';

class HelpItem extends StatelessWidget {
  final IconData icon;
  final String text;

  const HelpItem({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: 20,
          color: isDark ? AppColorsDark.mainColor : AppColorsLight.mainColor,
        ),
        const SizedBox(width: 12),
        TextInAppWidget(
          text: text,
          textSize: 14,
          fontWeightIndex: FontSelectionData.regularFontFamily,
          textColor: isDark
              ? AppColorsDark.appTextColor
              : AppColorsLight.appTextColor,
        ),
      ],
    );
  }
}
