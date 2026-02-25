import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:spex/core/helpers/colors/dark_colors.dart';
import 'package:spex/core/helpers/colors/light_colors.dart';
import 'package:spex/core/helpers/constants/constants.dart';
import 'package:spex/core/widgets/network_image_widget.dart';
import 'package:spex/core/widgets/text_in_app_widget.dart';
import 'package:spex/feature/search/model/search_item_model.dart';
import 'package:spex/generated/locale_keys.g.dart';
import 'package:spex/main.dart';

class SearchProductItem extends StatelessWidget {
  final SearchItemModel product;
  final VoidCallback? onTap;

  const SearchProductItem({super.key, required this.product, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isDark
              ? AppColorsDark.appSecondBgColor
              : AppColorsLight.whiteColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isDark
                ? AppColorsDark.appSecondTextColor.withValues(alpha: 0.1)
                : AppColorsLight.spexGrayColor,
            width: 1,
          ),
        ),
        child: Row(
          children: [
            // Product Image
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Container(
                width: 90,
                height: 90,
                color: isDark
                    ? AppColorsDark.appBgColor
                    : AppColorsLight.appBgColor,
                child: NetworkImageWidget(
                  imageUrl: product.image ?? '',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 12),

            // Product Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product Name
                  TextInAppWidget(
                    text: product.name ?? '',
                    textSize: 14,
                    fontWeightIndex: FontSelectionData.semiBoldFontFamily,
                    textColor: isDark
                        ? AppColorsDark.appTextColor
                        : AppColorsLight.appTextColor,
                    maxLines: 2,
                    isEllipsisTextOverflow: true,
                  ),
                  const SizedBox(height: 8),

                  // Price and Rating Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Price
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextInAppWidget(
                            text:
                                '${product.price ?? 0} ${LocaleKeys.home_egp.tr()}',
                            textSize: 14,
                            fontWeightIndex: FontSelectionData.boldFontFamily,
                            textColor: AppColorsLight
                                .mainColor, // Main color usually looks good for price in both modes
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
