import 'package:flutter/material.dart';
import '../../../../core/helpers/colors/dark_colors.dart';
import '../../../../core/helpers/colors/light_colors.dart';
import '../../../../core/widgets/text_in_app_widget.dart';
import '../../../../core/helpers/constants/constants.dart';
import '../../../../main.dart';

class FeatureItem extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String text;

  const FeatureItem({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: iconColor, size: 20),
        const SizedBox(width: 12),
        Expanded(
          child: TextInAppWidget(
            text: text,
            textSize: 15,
            textColor: isDark
                ? AppColorsDark.appTextColor
                : AppColorsLight.appTextColor.withValues(alpha: 0.8),
            fontWeightIndex: FontSelectionData.regularFontFamily,
          ),
        ),
      ],
    );
  }
}
