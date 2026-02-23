import 'package:flutter/material.dart';
import '../../../../core/helpers/colors/light_colors.dart';
import '../../../../core/helpers/colors/dark_colors.dart';
import '../../../../core/widgets/text_in_app_widget.dart';
import '../../../../core/helpers/constants/constants.dart';
import '../../../../main.dart';

class ServiceItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final String? actionText;
  final VoidCallback? onAction;

  const ServiceItem({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.actionText,
    this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              icon,
              color: isDark
                  ? AppColorsDark.mainColor
                  : AppColorsLight.mainColor,
              size: 24,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextInAppWidget(
                    text: title,
                    textSize: 14,
                    fontWeightIndex: FontSelectionData.boldFontFamily,
                    textColor: isDark
                        ? AppColorsDark.appTextColor
                        : AppColorsLight.appTextColor,
                    isEllipsisTextOverflow: true,
                    maxLines: 1,
                  ),
                  const SizedBox(height: 4),
                  TextInAppWidget(
                    text: subtitle,
                    textSize: 12,
                    fontWeightIndex: FontSelectionData.regularFontFamily,
                    textColor: isDark
                        ? AppColorsDark.appSecondTextColor
                        : AppColorsLight.appSecondTextColor,
                    isEllipsisTextOverflow: true,
                    maxLines: 2,
                  ),
                ],
              ),
            ),
          ],
        ),
        if (actionText != null) ...[
          const SizedBox(height: 12),
          Align(
            alignment: Alignment.centerRight,
            child: InkWell(
              onTap: onAction,
              child: Padding(
                padding: const EdgeInsets.only(left: 8, bottom: 4),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextInAppWidget(
                      text: actionText!,
                      textSize: 13,
                      fontWeightIndex: FontSelectionData.semiBoldFontFamily,
                      textColor: isDark
                          ? AppColorsDark.appTextColor
                          : AppColorsLight.appTextColor,
                      isEllipsisTextOverflow: true,
                      maxLines: 1,
                    ),
                    const SizedBox(width: 4),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 11,
                      color: isDark
                          ? AppColorsDark.appTextColor
                          : AppColorsLight.appTextColor,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }
}
