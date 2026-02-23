import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:spex/core/helpers/colors/dark_colors.dart';
import 'package:spex/core/helpers/colors/light_colors.dart';
import 'package:spex/core/helpers/constants/constants.dart';
import 'package:spex/core/helpers/extentions/extentions.dart';
import 'package:spex/core/widgets/text_in_app_widget.dart';
import 'package:spex/generated/locale_keys.g.dart';
import 'package:spex/main.dart';

class ShippingAddressCard extends StatelessWidget {
  final String name;
  final String address;

  const ShippingAddressCard({
    super.key,
    required this.name,
    required this.address,
  });

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
            text: LocaleKeys.orders_shipping_address.tr(),
            textSize: 12,
            fontWeightIndex: FontSelectionData.boldFontFamily,
            textColor: isDark
                ? AppColorsDark.appSecondTextColor
                : AppColorsLight.appSecondTextColor,
          ),
          verticalSpace(16),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: isDark
                      ? AppColorsDark.appBgColor
                      : AppColorsLight.appSecondBgColor,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.location_on,
                  color: isDark
                      ? AppColorsDark.appSecondTextColor
                      : AppColorsLight.appSecondTextColor,
                  size: 20,
                ),
              ),
              horizontalSpace(16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextInAppWidget(
                      text: name,
                      textSize: 16,
                      fontWeightIndex: FontSelectionData.boldFontFamily,
                      textColor: isDark
                          ? AppColorsDark.whiteColor
                          : AppColorsLight.appTextColor,
                    ),
                    TextInAppWidget(
                      text: address,
                      textSize: 13,
                      textColor: isDark
                          ? AppColorsDark.appSecondTextColor
                          : AppColorsLight.appSecondTextColor,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
