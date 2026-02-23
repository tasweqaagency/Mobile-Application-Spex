import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:spex/core/helpers/colors/dark_colors.dart';
import 'package:spex/core/helpers/colors/light_colors.dart';
import 'package:spex/core/helpers/constants/constants.dart';
import 'package:spex/core/helpers/extentions/extentions.dart';
import 'package:spex/core/widgets/text_in_app_widget.dart';
import 'package:spex/feature/orders/model/order_model.dart';
import 'package:spex/feature/orders/presentation/widgets/order_status_badge.dart';
import 'package:spex/generated/locale_keys.g.dart';
import 'package:spex/main.dart';

class OrderDetailHeader extends StatelessWidget {
  final OrderModel order;

  const OrderDetailHeader({super.key, required this.order});

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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextInAppWidget(
                    text: LocaleKeys.orders_order_id.tr().toUpperCase(),
                    textSize: 10,
                    fontWeightIndex: FontSelectionData.boldFontFamily,
                    textColor: isDark
                        ? AppColorsDark.appSecondTextColor
                        : AppColorsLight.appSecondTextColor,
                  ),
                  TextInAppWidget(
                    text: "#${order.id}",
                    textSize: 22,
                    fontWeightIndex: FontSelectionData.boldFontFamily,
                    textColor: isDark
                        ? AppColorsDark.whiteColor
                        : AppColorsLight.appTextColor,
                  ),
                ],
              ),
              OrderStatusBadge(status: order.status),
            ],
          ),
          verticalSpace(8),
          TextInAppWidget(
            text:
                "${LocaleKeys.orders_placed_on.tr()} ${DateFormat("MMM dd, yyyy").format(order.date)}",
            textSize: 14,
            textColor: isDark
                ? AppColorsDark.appSecondTextColor
                : AppColorsLight.appSecondTextColor,
          ),
        ],
      ),
    );
  }
}
