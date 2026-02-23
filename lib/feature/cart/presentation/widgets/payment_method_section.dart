import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:spex/core/helpers/colors/dark_colors.dart';
import 'package:spex/core/helpers/colors/light_colors.dart';
import 'package:spex/core/widgets/text_in_app_widget.dart';
import 'package:spex/generated/locale_keys.g.dart';
import 'package:spex/main.dart';

import 'package:spex/feature/cart/presentation/widgets/payment_option_widget.dart';

class PaymentMethodSection extends StatefulWidget {
  const PaymentMethodSection({super.key});

  @override
  State<PaymentMethodSection> createState() => _PaymentMethodSectionState();
}

class _PaymentMethodSectionState extends State<PaymentMethodSection> {
  late String _selectedMethod;

  @override
  void initState() {
    super.initState();
    _selectedMethod = LocaleKeys.cart_credit_debit_card;
  }

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
            text: LocaleKeys.cart_payment_method.tr(),
            textSize: 16,
            fontWeightIndex: 700,
            textColor: isDark
                ? AppColorsDark.whiteColor
                : AppColorsLight.appTextColor,
          ),
          const SizedBox(height: 16),
          PaymentOptionWidget(
            title: LocaleKeys.cart_credit_debit_card.tr(),
            isSelected: _selectedMethod == LocaleKeys.cart_credit_debit_card,
            icon: Icons.credit_card,
            onTap: () => setState(
              () => _selectedMethod = LocaleKeys.cart_credit_debit_card,
            ),
          ),
          const SizedBox(height: 8),
          PaymentOptionWidget(
            title: LocaleKeys.cart_pay_on_delivery.tr(),
            isSelected: _selectedMethod == LocaleKeys.cart_pay_on_delivery,
            icon: Icons.payments_outlined,
            onTap: () => setState(
              () => _selectedMethod = LocaleKeys.cart_pay_on_delivery,
            ),
          ),
        ],
      ),
    );
  }
}
