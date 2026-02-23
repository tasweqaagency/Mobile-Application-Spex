import 'package:flutter/material.dart';
import 'package:spex/core/helpers/colors/dark_colors.dart';
import 'package:spex/core/helpers/colors/light_colors.dart';
import 'package:spex/core/widgets/text_in_app_widget.dart';
import 'package:spex/core/helpers/constants/constants.dart';
import 'package:spex/main.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final String? actionText;
  final VoidCallback? onActionPressed;

  const SectionHeader({
    super.key,
    required this.title,
    this.actionText,
    this.onActionPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextInAppWidget(
          text: title,
          textSize: 18,
          fontWeightIndex: FontSelectionData.boldFontFamily,
          textColor: isDark
              ? AppColorsDark.appTextColor
              : AppColorsLight.darkColor,
        ),
        if (actionText != null)
          TextButton(
            onPressed: onActionPressed,
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: Row(
              children: [
                TextInAppWidget(
                  text: actionText!,
                  textSize: 14,
                  textColor: AppColorsLight.mainColor,
                ),
                SizedBox(width: 4),
                Icon(
                  Icons.chevron_right,
                  size: 16,
                  color: AppColorsLight.mainColor,
                ),
              ],
            ),
          ),
      ],
    );
  }
}
