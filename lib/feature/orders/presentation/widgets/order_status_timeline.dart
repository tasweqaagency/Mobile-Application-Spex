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

import 'package:spex/feature/orders/presentation/widgets/orders_timeline_item.dart';

class OrderStatusTimeline extends StatelessWidget {
  final OrderStatus currentStatus;
  final DateTime orderDate;

  const OrderStatusTimeline({
    super.key,
    required this.currentStatus,
    required this.orderDate,
  });

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
            text: LocaleKeys.orders_order_status.tr(),
            textSize: 12,
            fontWeightIndex: FontSelectionData.boldFontFamily,
            textColor: isDark
                ? AppColorsDark.appSecondTextColor
                : AppColorsLight.appSecondTextColor,
          ),
          verticalSpace(16),
          OrdersTimelineItem(
            title: LocaleKeys.orders_delivered.tr(),
            date: orderDate.add(const Duration(days: 3)),
            completed: currentStatus == OrderStatus.delivered,
            isLast: true,
          ),
          OrdersTimelineItem(
            title: LocaleKeys.orders_shipped.tr(),
            date: orderDate.add(const Duration(days: 2)),
            completed:
                currentStatus == OrderStatus.delivered ||
                currentStatus == OrderStatus.inTransit,
          ),
          OrdersTimelineItem(
            title: LocaleKeys.orders_processed.tr(),
            date: orderDate.add(const Duration(days: 1)),
            completed: currentStatus != OrderStatus.orderPlaced,
          ),
          OrdersTimelineItem(
            title: LocaleKeys.orders_order_placed.tr(),
            date: orderDate,
            completed: true,
            isFirst: true,
          ),
        ].reversed.toList(),
      ),
    );
  }
}
