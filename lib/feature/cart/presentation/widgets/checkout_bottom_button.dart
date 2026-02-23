import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:spex/core/helpers/colors/dark_colors.dart';
import 'package:spex/core/helpers/colors/light_colors.dart';
import 'package:spex/core/widgets/app_button.dart';
import 'package:spex/generated/locale_keys.g.dart';
import 'package:spex/main.dart';

class CheckoutBottomButton extends StatelessWidget {
  const CheckoutBottomButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      decoration: BoxDecoration(
        color: isDark ? AppColorsDark.appBgColor : AppColorsLight.whiteColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: AppTextButton(
                buttonText: LocaleKeys.cart_checkout_now.tr(),
                textStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColorsLight.whiteColor,
                ),
                onPressed: () {},
                borderRadius: 20,
                backgroundColor: AppColorsLight
                    .mainColor, // AppTextButton uses mainColor by default but I can override if needed
                buttonHeight: 56,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
