import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spex/core/helpers/colors/dark_colors.dart';
import 'package:spex/core/helpers/colors/light_colors.dart';
import 'package:spex/core/helpers/constants/constants.dart';
import 'package:spex/core/helpers/extentions/extentions.dart';
import 'package:spex/core/widgets/network_image_widget.dart';
import 'package:spex/core/widgets/text_in_app_widget.dart';
import 'package:spex/main.dart';

import 'package:spex/feature/cart/presentation/widgets/quantity_selector_widget.dart';

class CartItemWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final String price;
  final String imageUrl;
  final int quantity;
  final VoidCallback onRemove;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const CartItemWidget({
    super.key,
    required this.title,
    required this.subtitle,
    required this.price,
    required this.imageUrl,
    required this.quantity,
    required this.onRemove,
    required this.onIncrement,
    required this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.all(10),
      decoration: myBoxDecoration(),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          NetworkImageWidget(
            imageUrl: imageUrl,
            width: 80.w,
            height: 80.w,
            borderRadius: BorderRadius.circular(18.r),
          ),
          SizedBox(width: 12),
          // Product Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: TextInAppWidget(
                        text: title,
                        textColor: isDark
                            ? AppColorsDark.appTextColor
                            : AppColorsLight.appTextColor,
                        textSize: 14,
                        fontWeightIndex: FontSelectionData.semiBoldFontFamily,
                        isEllipsisTextOverflow: true,
                        maxLines: 1,
                      ),
                    ),
                    IconButton(
                      onPressed: onRemove,
                      icon: Icon(
                        Icons.close,
                        size: 20.sp,
                        color: isDark
                            ? AppColorsDark.appSecondTextColor
                            : AppColorsLight.appSecondTextColor,
                      ),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      visualDensity: VisualDensity.compact,
                    ),
                  ],
                ),
                TextInAppWidget(
                  text: subtitle,
                  textSize: 12,
                  textColor: AppColorsLight.appSecondTextColor,
                  fontWeightIndex: FontSelectionData.regularFontFamily,
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextInAppWidget(
                      text: price,
                      textSize: 16,
                      fontWeightIndex: FontSelectionData.boldFontFamily,
                      textColor: AppColorsLight.mainColor,
                    ),
                    QuantitySelectorWidget(
                      quantity: quantity,
                      onIncrement: onIncrement,
                      onDecrement: onDecrement,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
