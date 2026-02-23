import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:spex/core/helpers/colors/dark_colors.dart';
import 'package:spex/core/helpers/colors/light_colors.dart';
import 'package:spex/core/helpers/constants/constants.dart';
import 'package:spex/core/helpers/extentions/extentions.dart';
import 'package:spex/core/widgets/text_in_app_widget.dart';
import 'package:spex/feature/orders/model/order_model.dart';
import 'package:spex/feature/orders/presentation/widgets/price_row.dart';
import 'package:spex/generated/locale_keys.g.dart';
import 'package:spex/main.dart';

class OrderDetailPriceDetailsSection extends StatelessWidget {
  final OrderModel order;

  const OrderDetailPriceDetailsSection({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark
            ? AppColorsDark.appSecondBgColor
            : AppColorsLight.whiteColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextInAppWidget(
            text: LocaleKeys.orders_price_details.tr(),
            textSize: 12,
            fontWeightIndex: FontSelectionData.boldFontFamily,
            textColor: isDark
                ? AppColorsDark.appSecondTextColor
                : AppColorsLight.appSecondTextColor,
          ),
          verticalSpace(16),
          PriceRow(
            label: LocaleKeys.orders_subtotal.tr(),
            value:
                "${order.totalAmount - 1.0} ${LocaleKeys.cart_sar.tr()}", // Just mock logic
          ),
          verticalSpace(12),
          PriceRow(
            label: LocaleKeys.orders_shipping_fee.tr(),
            value: LocaleKeys.cart_free.tr(),
            valueColor: AppColorsLight.greenColor2,
          ),
          verticalSpace(16),
          dividerHorizontal(),
          verticalSpace(16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextInAppWidget(
                text: LocaleKeys.orders_grand_total.tr(),
                textSize: 16,
                fontWeightIndex: FontSelectionData.boldFontFamily,
                textColor: isDark
                    ? AppColorsDark.whiteColor
                    : AppColorsLight.appTextColor,
              ),
              TextInAppWidget(
                text: "${order.totalAmount} ${LocaleKeys.cart_sar.tr()}",
                textSize: 20,
                fontWeightIndex: FontSelectionData.boldFontFamily,
                textColor: AppColorsLight.mainColor,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
