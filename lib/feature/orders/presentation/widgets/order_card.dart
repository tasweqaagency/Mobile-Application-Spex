import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spex/core/helpers/colors/dark_colors.dart';
import 'package:spex/core/helpers/colors/light_colors.dart';
import 'package:spex/core/helpers/constants/constants.dart';
import 'package:spex/core/helpers/extentions/extentions.dart';
import 'package:spex/core/widgets/app_button.dart';
import 'package:spex/core/widgets/text_in_app_widget.dart';
import 'package:spex/feature/orders/model/order_model.dart';
import 'package:spex/feature/orders/presentation/widgets/order_status_badge.dart';
import 'package:spex/generated/locale_keys.g.dart';
import 'package:spex/main.dart';

class OrderCard extends StatelessWidget {
  final OrderModel order;
  final VoidCallback onTap;

  const OrderCard({super.key, required this.order, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark
            ? AppColorsDark.appSecondBgColor
            : AppColorsLight.whiteColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextInAppWidget(
                text: "${LocaleKeys.orders_order_id.tr()} ${order.id}",
                textSize: 12,
                textColor: isDark
                    ? AppColorsDark.appSecondTextColor
                    : AppColorsLight.appSecondTextColor,
                fontWeightIndex: FontSelectionData.regularFontFamily,
              ),
              OrderStatusBadge(status: order.status),
            ],
          ),
          verticalSpace(4),
          TextInAppWidget(
            text: DateFormat("MMM dd, yyyy").format(order.date),
            textSize: 16,
            fontWeightIndex: FontSelectionData.boldFontFamily,
            textColor: isDark
                ? AppColorsDark.whiteColor
                : AppColorsLight.appTextColor,
          ),
          verticalSpace(16),
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 40,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: order.items.length > 3 ? 3 : order.items.length,
                    separatorBuilder: (context, index) => horizontalSpace(8),
                    itemBuilder: (context, index) {
                      if (index == 2 && order.items.length > 3) {
                        return Container(
                          width: 40,
                          decoration: BoxDecoration(
                            color: isDark
                                ? AppColorsDark.appBgColor
                                : AppColorsLight.appSecondBgColor,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: TextInAppWidget(
                              text: "+${order.items.length - 2}",
                              textSize: 12,
                              fontWeightIndex: FontSelectionData.boldFontFamily,
                              textColor: isDark
                                  ? AppColorsDark.appSecondTextColor
                                  : AppColorsLight.appSecondTextColor,
                            ),
                          ),
                        );
                      }
                      return Container(
                        width: 40,
                        decoration: BoxDecoration(
                          color: isDark
                              ? AppColorsDark.appBgColor
                              : AppColorsLight.appSecondBgColor,
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                            image: AssetImage(
                              order.items[index].product.imagePath.first,
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextInAppWidget(
                    text: LocaleKeys.cart_total.tr(),
                    textSize: 12,
                    textColor: isDark
                        ? AppColorsDark.appSecondTextColor
                        : AppColorsLight.appSecondTextColor,
                    fontWeightIndex: FontSelectionData.regularFontFamily,
                  ),
                  TextInAppWidget(
                    text: "${order.totalAmount} ${LocaleKeys.cart_sar.tr()}",
                    textSize: 18,
                    fontWeightIndex: FontSelectionData.boldFontFamily,
                    textColor: AppColorsLight.mainColor,
                  ),
                ],
              ),
            ],
          ),
          if (order.status == OrderStatus.inTransit) ...[
            verticalSpace(16),
            const _MiniTimeline(),
          ],
          verticalSpace(16),
          AppTextButton(
            buttonText: LocaleKeys.orders_order_details.tr(),
            onPressed: onTap,
            backgroundColor: isDark
                ? AppColorsDark.darktGrayColor
                : AppColorsLight.darktGrayColor,
            textStyle: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class _MiniTimeline extends StatelessWidget {
  const _MiniTimeline();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _TimelineDot(
          label: LocaleKeys.orders_order_placed.tr(),
          completed: true,
        ),
        const _TimelineLine(completed: true),
        _TimelineDot(label: LocaleKeys.orders_shipped.tr(), completed: true),
        const _TimelineLine(completed: true),
        _TimelineDot(label: LocaleKeys.orders_in_transit.tr(), completed: true),
        const _TimelineLine(completed: false),
        _TimelineDot(label: LocaleKeys.orders_delivered.tr(), completed: false),
      ],
    );
  }
}

class _TimelineDot extends StatelessWidget {
  final String label;
  final bool completed;

  const _TimelineDot({required this.label, required this.completed});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: completed
                ? AppColorsLight.mainColor
                : (isDark ? Colors.grey[700] : Colors.grey[300]),
          ),
        ),
        verticalSpace(4),
        TextInAppWidget(
          text: label.split(' ').first.toUpperCase(),
          textSize: 8,
          fontWeightIndex: FontSelectionData.boldFontFamily,
          textColor: completed
              ? AppColorsLight.mainColor
              : (isDark ? Colors.grey[600] : Colors.grey[400]),
        ),
      ],
    );
  }
}

class _TimelineLine extends StatelessWidget {
  final bool completed;

  const _TimelineLine({required this.completed});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 2,
        color: completed
            ? AppColorsLight.mainColor
            : (isDark ? Colors.grey[700] : Colors.grey[300]),
      ),
    );
  }
}
