import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:spex/core/helpers/extentions/extentions.dart';
import 'package:spex/feature/home/presentation/widgets/my_appbar.dart';
import 'package:spex/feature/orders/model/order_model.dart';
import 'package:spex/feature/orders/presentation/widgets/order_detail_header.dart';
import 'package:spex/feature/orders/presentation/widgets/order_detail_price_details_section.dart';
import 'package:spex/feature/orders/presentation/widgets/order_detail_summary_section.dart';
import 'package:spex/feature/orders/presentation/widgets/order_status_timeline.dart';
import 'package:spex/feature/orders/presentation/widgets/shipping_address_card.dart';
import 'package:spex/generated/locale_keys.g.dart';

class OrderDetailsScreen extends StatelessWidget {
  final OrderModel order;

  const OrderDetailsScreen({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBarWithBackButton(
        title: LocaleKeys.orders_order_details.tr(),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            OrderDetailHeader(order: order),
            verticalSpace(16),
            OrderStatusTimeline(
              currentStatus: order.status,
              orderDate: order.date,
            ),
            verticalSpace(16),
            const ShippingAddressCard(
              name: "Alex Thompson",
              address:
                  "1284 Tech Boulevard, Suite 500\nSan Francisco, CA 94105\nUnited States",
            ),
            verticalSpace(16),
            OrderDetailSummarySection(order: order),
            verticalSpace(16),
            OrderDetailPriceDetailsSection(order: order),
            verticalSpace(24),
          ],
        ),
      ),
    );
  }
}
