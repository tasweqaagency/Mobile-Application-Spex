import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:spex/core/helpers/colors/dark_colors.dart';
import 'package:spex/core/helpers/colors/light_colors.dart';
import 'package:spex/core/helpers/constants/constants.dart';
import 'package:spex/core/helpers/extentions/extentions.dart';
import 'package:spex/core/widgets/text_in_app_widget.dart';
import 'package:spex/feature/orders/model/order_model.dart';
import 'package:spex/generated/locale_keys.g.dart';
import 'package:spex/main.dart';

class OrderItemCard extends StatelessWidget {
  final OrderItemModel item;

  const OrderItemCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: isDark
                  ? AppColorsDark.appBgColor
                  : AppColorsLight.appSecondBgColor,
              borderRadius: BorderRadius.circular(12),
              image: DecorationImage(
                image: AssetImage(item.product.imagePath.first),
                fit: BoxFit.cover,
              ),
            ),
          ),
          horizontalSpace(16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextInAppWidget(
                  text: item.product.name,
                  textSize: 14,
                  fontWeightIndex: FontSelectionData.boldFontFamily,
                  textColor: isDark
                      ? AppColorsDark.whiteColor
                      : AppColorsLight.appTextColor,
                  isEllipsisTextOverflow: true,
                ),
                TextInAppWidget(
                  text: "${LocaleKeys.orders_quantity.tr()}: ${item.quantity}",
                  textSize: 12,
                  textColor: isDark
                      ? AppColorsDark.appSecondTextColor
                      : AppColorsLight.appSecondTextColor,
                ),
              ],
            ),
          ),
          TextInAppWidget(
            text: "${item.product.price} ${LocaleKeys.cart_sar.tr()}",
            textSize: 14,
            fontWeightIndex: FontSelectionData.boldFontFamily,
            textColor: isDark
                ? AppColorsDark.whiteColor
                : AppColorsLight.appTextColor,
          ),
        ],
      ),
    );
  }
}
