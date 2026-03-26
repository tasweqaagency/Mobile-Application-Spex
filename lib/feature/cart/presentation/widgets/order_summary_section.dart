import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:spex/core/helpers/colors/dark_colors.dart';
import 'package:spex/core/helpers/colors/light_colors.dart';
import 'package:spex/core/widgets/text_in_app_widget.dart';
import 'package:spex/generated/locale_keys.g.dart';
import 'package:spex/main.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spex/feature/cart/view_model/cart_cubit.dart';
import 'package:spex/feature/cart/view_model/cart_state.dart';

import 'package:spex/feature/cart/presentation/widgets/summary_row_widget.dart';

class OrderSummarySection extends StatelessWidget {
  const OrderSummarySection({super.key});

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
      child: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          final cubit = context.read<CartCubit>();
          final total = cubit.totalPrice;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextInAppWidget(
                text: LocaleKeys.cart_order_summary.tr(),
                textSize: 16,
                fontWeightIndex: 700,
                textColor: isDark
                    ? AppColorsDark.whiteColor
                    : AppColorsLight.appTextColor,
              ),
              const SizedBox(height: 16),
              SummaryRowWidget(
                label: LocaleKeys.cart_subtotal.tr(),
                value: '$total ${LocaleKeys.home_egp.tr()}',
              ),
              const SizedBox(height: 12),
              SummaryRowWidget(
                label: LocaleKeys.cart_shipping.tr(),
                value: LocaleKeys.cart_free.tr(),
                valueColor: AppColorsLight.greenColor2,
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextInAppWidget(
                    text: LocaleKeys.cart_total.tr(),
                    textSize: 16,
                    fontWeightIndex: 700,
                    textColor: isDark
                        ? AppColorsDark.whiteColor
                        : AppColorsLight.appTextColor,
                  ),
                  TextInAppWidget(
                    text: '$total ${LocaleKeys.home_egp.tr()}',
                    textSize: 20,
                    fontWeightIndex: 800,
                    textColor: AppColorsLight.mainColor,
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
