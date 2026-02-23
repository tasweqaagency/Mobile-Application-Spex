import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:spex/core/helpers/colors/dark_colors.dart';
import 'package:spex/core/helpers/colors/light_colors.dart';
import 'package:spex/core/helpers/constants/constants.dart';
import 'package:spex/core/helpers/extentions/extentions.dart';
import 'package:spex/core/widgets/text_in_app_widget.dart';
import 'package:spex/feature/orders/model/order_model.dart';
import 'package:spex/feature/orders/presentation/widgets/order_item_card.dart';
import 'package:spex/generated/locale_keys.g.dart';
import 'package:spex/main.dart';

class OrderDetailSummarySection extends StatelessWidget {
  final OrderModel order;

  const OrderDetailSummarySection({super.key, required this.order});

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
            text: LocaleKeys.orders_order_summary.tr(),
            textSize: 12,
            fontWeightIndex: FontSelectionData.boldFontFamily,
            textColor: isDark
                ? AppColorsDark.appSecondTextColor
                : AppColorsLight.appSecondTextColor,
          ),
          verticalSpace(16),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: order.items.length,
            separatorBuilder: (context, index) => dividerHorizontal(),
            itemBuilder: (context, index) {
              return OrderItemCard(item: order.items[index]);
            },
          ),
        ],
      ),
    );
  }
}
