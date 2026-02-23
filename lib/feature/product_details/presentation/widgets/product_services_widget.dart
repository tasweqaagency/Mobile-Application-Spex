import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:spex/generated/locale_keys.g.dart';

import 'package:spex/feature/product_details/presentation/widgets/delivery_return_dialog.dart';
import 'package:spex/feature/product_details/presentation/widgets/service_card.dart';
import 'package:spex/feature/product_details/presentation/widgets/service_item.dart';

class ProductServicesWidget extends StatelessWidget {
  const ProductServicesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ServiceCard(
          children: [
            ServiceItem(
              icon: Icons.local_shipping_outlined,
              title: LocaleKeys.product_services_doorstep_delivery.tr(),
              subtitle: LocaleKeys.product_services_delivery_time.tr(),
              actionText: LocaleKeys.product_services_more_details.tr(),
              onAction: () {
                showDialog(
                  context: context,
                  builder: (context) => const DeliveryReturnDialog(),
                );
              },
            ),
            ServiceItem(
              icon: Icons.storefront_outlined,
              title: LocaleKeys.product_services_pickup_from_store.tr(),
              subtitle: LocaleKeys.product_services_pickup_time.tr(),
              actionText: LocaleKeys.product_services_check_availability.tr(),
              onAction: () {},
            ),
          ],
        ),
        const SizedBox(height: 12),
        ServiceCard(
          children: [
            ServiceItem(
              icon: Icons.payment_outlined,
              title: LocaleKeys.product_services_payment_options.tr(),
              subtitle: LocaleKeys.product_services_payment_methods.tr(),
            ),
            ServiceItem(
              icon: Icons.assignment_return_outlined,
              title: LocaleKeys.product_services_easy_returns.tr(),
              subtitle: LocaleKeys.product_services_return_time.tr(),
              actionText: LocaleKeys.product_services_more_details.tr(),
              onAction: () {
                showDialog(
                  context: context,
                  builder: (context) => const DeliveryReturnDialog(),
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}
