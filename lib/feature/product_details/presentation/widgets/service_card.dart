import 'package:flutter/material.dart';
import '../../../../core/helpers/colors/light_colors.dart';
import '../../../../core/helpers/colors/dark_colors.dart';
import '../../../../main.dart';

class ServiceCard extends StatelessWidget {
  final List<Widget> children;
  const ServiceCard({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isDark
            ? AppColorsDark.appSecondBgColor
            : AppColorsLight.whiteColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDark
              ? AppColorsDark.appSecondTextColor.withValues(alpha: 0.1)
              : AppColorsLight.appSecondTextColor.withValues(alpha: 0.1),
        ),
      ),
      padding: const EdgeInsets.all(16),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: children[0]),
            VerticalDivider(
              color: isDark
                  ? AppColorsDark.appSecondTextColor.withValues(alpha: 0.1)
                  : AppColorsLight.appSecondTextColor.withValues(alpha: 0.1),
              width: 32,
              thickness: 1,
            ),
            Expanded(child: children[1]),
          ],
        ),
      ),
    );
  }
}
