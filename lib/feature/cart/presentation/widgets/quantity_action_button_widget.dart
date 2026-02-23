import 'package:flutter/material.dart';
import '../../../../core/helpers/colors/dark_colors.dart';
import '../../../../core/helpers/colors/light_colors.dart';
import '../../../../main.dart';

class QuantityActionButtonWidget extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const QuantityActionButtonWidget({
    super.key,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Icon(
          icon,
          size: 18,
          color: isDark
              ? AppColorsDark.appSecondTextColor
              : AppColorsLight.appSecondTextColor,
        ),
      ),
    );
  }
}
