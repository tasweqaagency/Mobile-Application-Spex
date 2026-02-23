import 'package:flutter/material.dart';
import 'package:spex/core/helpers/colors/light_colors.dart';
import 'package:spex/core/widgets/text_in_app_widget.dart';

class DrawerItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const DrawerItem({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: AppColorsLight.darkColor),
      title: TextInAppWidget(
        text: title,
        textSize: 16,
        textColor: AppColorsLight.darkColor,
      ),
      onTap: onTap,
    );
  }
}
