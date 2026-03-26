import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:spex/core/helpers/colors/dark_colors.dart';
import 'package:spex/core/helpers/colors/light_colors.dart';
import 'package:spex/core/helpers/constants/constants.dart';
import 'package:spex/core/widgets/text_in_app_widget.dart';
import 'package:spex/generated/locale_keys.g.dart';
import 'package:spex/main.dart';

class ProductPriceAndStock extends StatelessWidget {
  final String displayPrice;
  final String? displayOldPrice;
  final bool isInStock;

  const ProductPriceAndStock({
    super.key,
    required this.displayPrice,
    this.displayOldPrice,
    required this.isInStock,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            if (displayOldPrice != null &&
                displayOldPrice!.isNotEmpty &&
                displayOldPrice != displayPrice) ...[
              Flexible(
                child: TextInAppWidget(
                  text: '$displayOldPrice ${LocaleKeys.home_egp.tr()}',
                  textSize: 16,
                  textColor: isDark
                      ? AppColorsDark.appSecondTextColor
                      : AppColorsLight.appSecondTextColor,
                  isEllipsisTextOverflow: true,
                  maxLines: 1,
                  fontWeightIndex: FontSelectionData.regularFontFamily,
                  textDecoration: TextDecoration.lineThrough,
                  decorationColor: AppColorsLight.mainColor,
                  decorationThickness: 1.0,
                ),
              ),
              const SizedBox(width: 8),
            ],
            Flexible(
              child: TextInAppWidget(
                text: '$displayPrice ${LocaleKeys.home_egp.tr()}',
                textSize: 18,
                fontWeightIndex: FontSelectionData.boldFontFamily,
                textColor:
                    isDark ? AppColorsDark.mainColor : AppColorsLight.mainColor,
                isEllipsisTextOverflow: true,
                maxLines: 1,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        if (isInStock)
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.check_circle_outline_rounded,
                color: AppColorsDark.greenColor2,
                size: 20,
              ),
              const SizedBox(width: 4),
              TextInAppWidget(
                text: LocaleKeys.home_in_stock.tr(),
                textSize: 16,
                fontWeightIndex: FontSelectionData.boldFontFamily,
                textColor:
                    isDark ? AppColorsDark.greenColor2 : AppColorsLight.greenColor2,
              ),
            ],
          )
        else
          TextInAppWidget(
            text: LocaleKeys.home_out_of_stock.tr(),
            textSize: 14,
            fontWeightIndex: FontSelectionData.semiBoldFontFamily,
            textColor: isDark ? AppColorsDark.appRedColor : AppColorsLight.appRedColor,
          ),
      ],
    );
  }
}
