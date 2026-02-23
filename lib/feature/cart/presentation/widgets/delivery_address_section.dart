import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:spex/core/helpers/colors/dark_colors.dart';
import 'package:spex/core/helpers/colors/light_colors.dart';
import 'package:spex/core/helpers/constants/constants.dart';
import 'package:spex/core/widgets/text_in_app_widget.dart';
import 'package:spex/generated/locale_keys.g.dart';
import 'package:spex/main.dart';

class DeliveryAddressSection extends StatelessWidget {
  const DeliveryAddressSection({super.key});

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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextInAppWidget(
                text: LocaleKeys.cart_delivery_address.tr(),
                textSize: 16,
                fontWeightIndex: 700,
                textColor: isDark
                    ? AppColorsDark.whiteColor
                    : AppColorsLight.appTextColor,
              ),
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: TextInAppWidget(
                  text: LocaleKeys.cart_edit.tr(),
                  textSize: 14,
                  fontWeightIndex: 600,
                  textColor: AppColorsLight.mainColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isDark
                  ? AppColorsDark.appBgColor
                  : AppColorsLight.whiteColor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColorsLight.mainColor.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.location_on,
                    color: AppColorsLight.mainColor,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextInAppWidget(
                        text: LocaleKeys.cart_home.tr(),
                        textSize: 14,
                        fontWeightIndex: 700,
                        textColor: isDark
                            ? AppColorsDark.whiteColor
                            : AppColorsLight.appTextColor,
                      ),
                      TextInAppWidget(
                        text: '123 Street Name, City, Apartment 4B',
                        textSize: 12,
                        fontWeightIndex: 400,
                        textColor: isDark
                            ? AppColorsDark.appSecondTextColor
                            : AppColorsLight.appSecondTextColor,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              border: Border.all(
                color:
                    (isDark
                            ? AppColorsDark.appSecondTextColor
                            : AppColorsLight.appSecondTextColor)
                        .withValues(alpha: 0.3),
                style: BorderStyle.solid,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.add_location_alt_outlined,
                  size: 18,
                  color: isDark
                      ? AppColorsDark.appSecondTextColor
                      : AppColorsLight.appSecondTextColor,
                ),
                const SizedBox(width: 8),
                TextInAppWidget(
                  text: LocaleKeys.cart_add_new_address.tr(),
                  textSize: 13,
                  fontWeightIndex: FontSelectionData.regularFontFamily,
                  textColor: isDark
                      ? AppColorsDark.appSecondTextColor
                      : AppColorsLight.appSecondTextColor,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
