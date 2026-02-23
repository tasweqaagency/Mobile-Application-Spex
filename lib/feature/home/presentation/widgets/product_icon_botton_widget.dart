import 'package:flutter/material.dart';
import 'package:spex/core/helpers/colors/light_colors.dart';

class ProductIconBottonWidget extends StatelessWidget {
  const ProductIconBottonWidget({
    super.key,
    required this.icon,
    required this.onTap,
    required this.color,
  });
  final IconData icon;
  final VoidCallback onTap;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: CircleAvatar(
        radius: 13,
        backgroundColor: AppColorsLight.darktGrayColor.withValues(alpha: .7),
        child: Center(child: Icon(icon, color: color, size: 17)),
      ),
    );
  }
}
