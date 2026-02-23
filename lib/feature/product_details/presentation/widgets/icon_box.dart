import 'package:flutter/material.dart';
import 'package:spex/core/helpers/colors/light_colors.dart';
import 'package:spex/core/helpers/constants/constants.dart';
import 'package:spex/core/helpers/extentions/extentions.dart';

class IconBox extends StatelessWidget {
  final IconData? icon;

  final Color? iconColor;

  final String? iconPath;

  final double? width;

  final double? height;

  final double? iconSize;

  final double? imageWidth;

  final double? imageHeight;

  final void Function()? onTap;

  final bool withBorder;

  const IconBox({
    super.key,
    this.icon,
    this.iconColor = AppColorsLight.appTextColor,
    this.iconPath,
    this.width = 40,
    this.height = 40,
    this.iconSize = 25,
    this.imageWidth = 30,
    this.imageHeight = 30,
    this.onTap,
    this.withBorder = true,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    bool isMobile = size.width <= ValuesOfAllApp.mobileWidth;
    return InkWell(
      onTap: onTap,

      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      child: Container(
        width: width,
        height: height,
        decoration: withBorder
            ? myBoxDecorationWithBorder()
            : myBoxDecoration(),
        child: Center(
          child: iconPath == null
              ? Icon(icon, color: iconColor, size: iconSize)
              : Image.asset(
                  iconPath!,
                  width: isMobile ? 20 : imageWidth,
                  height: isMobile ? 20 : imageHeight,
                  fit: BoxFit.fill,
                ),
        ),
      ),
    );
  }
}
