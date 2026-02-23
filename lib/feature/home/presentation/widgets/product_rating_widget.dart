import 'package:flutter/material.dart';
import 'package:spex/core/helpers/colors/dark_colors.dart';
import 'package:spex/core/helpers/colors/light_colors.dart';
import 'package:spex/core/widgets/text_in_app_widget.dart';
import 'package:spex/main.dart';

class ProductRatingWidget extends StatelessWidget {
  final double rating;
  final double size;
  final Color? color;

  const ProductRatingWidget({
    super.key,
    required this.rating,
    this.size = 14,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 5,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(5, (index) {
            IconData icon;
            if (rating >= index + 1) {
              icon = Icons.star;
            } else if (rating >= index + 0.5) {
              icon = Icons.star_half;
            } else {
              icon = Icons.star_border;
            }
            return Icon(icon, color: color ?? Colors.amber, size: size);
          }),
        ),
        TextInAppWidget(
          text: "($rating)",
          textColor: isDark
              ? AppColorsDark.appTextColor
              : AppColorsLight.appTextColor,
          textSize: size,
        ),
      ],
    );
  }
}

class OneStarProductRatingWidget extends StatelessWidget {
  final double rating;
  final double size;
  final Color? color;

  const OneStarProductRatingWidget({
    super.key,
    required this.rating,
    this.size = 14,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isDark
            ? AppColorsDark.appSecondBgColor
            : AppColorsLight.whiteColor,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Row(
        spacing: 5,
        children: [
          Icon(Icons.star, color: color ?? Colors.amber, size: size),
          TextInAppWidget(
            text: "$rating",
            textColor: isDark
                ? AppColorsDark.appTextColor
                : AppColorsLight.appTextColor,
            textSize: size,
          ),
        ],
      ),
    );
  }
}
