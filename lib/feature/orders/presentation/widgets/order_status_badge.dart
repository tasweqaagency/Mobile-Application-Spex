import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:spex/core/helpers/colors/light_colors.dart';
import 'package:spex/core/helpers/constants/constants.dart';
import 'package:spex/core/widgets/text_in_app_widget.dart';
import 'package:spex/feature/orders/model/order_model.dart';
import 'package:spex/generated/locale_keys.g.dart';

class OrderStatusBadge extends StatelessWidget {
  final OrderStatus status;

  const OrderStatusBadge({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    Color bgColor;
    Color textColor;
    String text;

    switch (status) {
      case OrderStatus.delivered:
        bgColor = AppColorsLight.greenColor2.withValues(alpha: 0.1);
        textColor = AppColorsLight.greenColor2;
        text = LocaleKeys.orders_delivered.tr();
        break;
      case OrderStatus.inTransit:
        bgColor = Colors.blue.withValues(alpha: 0.1);
        textColor = Colors.blue;
        text = LocaleKeys.orders_in_transit.tr();
        break;
      case OrderStatus.processed:
        bgColor = Colors.orange.withValues(alpha: 0.1);
        textColor = Colors.orange;
        text = LocaleKeys.orders_processed.tr();
        break;
      case OrderStatus.orderPlaced:
        bgColor = Colors.grey.withValues(alpha: 0.1);
        textColor = Colors.grey;
        text = LocaleKeys.orders_order_placed.tr();
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(25),
      ),
      child: TextInAppWidget(
        text: text.toUpperCase(),
        textSize: 12,
        fontWeightIndex: FontSelectionData.boldFontFamily,
        textColor: textColor,
      ),
    );
  }
}
