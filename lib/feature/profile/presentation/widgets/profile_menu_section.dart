import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spex/core/helpers/colors/dark_colors.dart';
import 'package:spex/core/helpers/colors/light_colors.dart';
import 'package:spex/core/helpers/constants/constants.dart';
import 'package:spex/core/helpers/extentions/extentions.dart';
import 'package:spex/core/widgets/text_in_app_widget.dart';
import 'package:spex/main.dart';

class ProfileMenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final Color? iconColor;
  final Color? iconBgColor;
  final Widget? trailing;

  const ProfileMenuItem({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
    this.iconColor,
    this.iconBgColor,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isDark
              ? (iconColor ?? AppColorsLight.mainColor).withValues(alpha: 0.15)
              : (iconBgColor ??
                    AppColorsLight.mainColor.withValues(alpha: 0.1)),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          icon,
          color: iconColor ?? AppColorsLight.mainColor,
          size: 20,
        ),
      ),
      title: TextInAppWidget(
        text: title,
        textSize: 14,
        fontWeightIndex: FontSelectionData.semiBoldFontFamily,
        textColor: isDark
            ? AppColorsDark.appTextColor
            : AppColorsLight.appTextColor,
      ),
      trailing:
          trailing ??
          Icon(
            Icons.arrow_forward_ios,
            size: 16,
            color: isDark
                ? AppColorsDark.appTextColor
                : AppColorsLight.appTextColor,
          ),
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
    );
  }
}

class ProfileMenuSection extends StatelessWidget {
  final List<ProfileMenuItem> items;

  const ProfileMenuSection({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      decoration: myBoxDecoration(),
      child: Column(
        children: List.generate(items.length, (index) {
          return Column(
            children: [
              items[index],
              if (index != items.length - 1)
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Divider(
                    height: 1,
                    color: AppColorsLight.appSecondTextColor.withValues(
                      alpha: 0.1,
                    ),
                  ),
                ),
            ],
          );
        }),
      ),
    );
  }
}
