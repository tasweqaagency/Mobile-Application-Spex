import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:spex/core/helpers/colors/dark_colors.dart';
import 'package:spex/core/helpers/colors/light_colors.dart';
import 'package:spex/feature/cart/presentation/widgets/applyed_widget.dart';
import 'package:spex/feature/cart/presentation/widgets/cart_apply_botton.dart';
import 'package:spex/generated/locale_keys.g.dart';
import 'package:spex/main.dart';

class CouponSection extends StatelessWidget {
  const CouponSection({super.key});
  // final formKey= GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    bool isCouponApplied = false;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,

      children: [
        isCouponApplied
            ? Flexible(
                child: ApplyedWidget(
                  applyedAmount: 100,
                  applyedText: LocaleKeys.cart_discount_from_coupon.tr(),
                ),
              )
            : Flexible(
                child: SizedBox(
                  height: 55,
                  child: TextFormField(
                    style: TextStyle(
                      color: isDark
                          ? AppColorsDark.whiteColor
                          : AppColorsLight.appTextColor,
                      fontSize: 14,
                      decoration: TextDecoration.none,
                    ),
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      isDense: true,
                      alignLabelWithHint: true,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 16,
                      ),
                      fillColor: isDark
                          ? AppColorsDark.appSecondBgColor
                          : AppColorsLight.whiteColor,
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(
                          color: isDark
                              ? AppColorsDark.appSecondTextColor.withValues(
                                  alpha: 0.3,
                                )
                              : AppColorsLight.appSecondTextColor.withValues(
                                  alpha: 0.5,
                                ),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(
                          color: AppColorsLight.mainColor,
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(
                          color: AppColorsLight.mainAccentColor,
                        ),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(
                          color: AppColorsLight.mainAccentColor,
                        ),
                      ),
                      hintText: LocaleKeys.cart_enter_coupon_code.tr(),
                      hintStyle: TextStyle(
                        color: isDark
                            ? AppColorsDark.appSecondTextColor
                            : AppColorsLight.appSecondTextColor,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ),
        const SizedBox(width: 10),
        CartApplyBotton(onPressed: () {}, isApply: isCouponApplied),
      ],
    );
  }
}
