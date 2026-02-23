import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:spex/feature/home/model/product_model.dart';
import 'package:spex/generated/locale_keys.g.dart';
import '../../../../core/helpers/colors/light_colors.dart';
import '../../../../core/helpers/colors/dark_colors.dart';
import '../../../../core/widgets/text_in_app_widget.dart';
import '../../../../core/helpers/constants/constants.dart';
import '../../../../main.dart';

class ProductGiftWidget extends StatelessWidget {
  final ProductModel giftProduct;
  const ProductGiftWidget({super.key, required this.giftProduct});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isDark
            ? AppColorsDark.appSecondBgColor
            : AppColorsLight.whiteColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDark
              ? AppColorsDark.appSecondTextColor.withValues(alpha: 0.1)
              : AppColorsLight.appSecondTextColor.withValues(alpha: 0.1),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Icon(
            Icons.card_giftcard_outlined,
            color: isDark ? AppColorsDark.mainColor : AppColorsLight.mainColor,
            size: 24,
          ),
          const SizedBox(width: 12),
          if (giftProduct.imagePath.isNotEmpty)
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                giftProduct.imagePath.first,
                height: 48,
                width: 48,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  height: 48,
                  width: 48,
                  color: isDark
                      ? AppColorsDark.darkColor
                      : AppColorsLight.lightGrayColor,
                  child: const Icon(Icons.image_outlined, size: 20),
                ),
              ),
            ),
          const SizedBox(width: 12),
          Expanded(
            child: TextInAppWidget(
              text: giftProduct.name,
              textSize: 14,
              fontWeightIndex: FontSelectionData.semiBoldFontFamily,
              textColor: isDark
                  ? AppColorsDark.appTextColor
                  : AppColorsLight.appTextColor,
              maxLines: 2,
              isEllipsisTextOverflow: true,
            ),
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextInAppWidget(
                text: LocaleKeys.cart_free.tr(),
                textSize: 16,
                fontWeightIndex: FontSelectionData.boldFontFamily,
                textColor: isDark
                    ? AppColorsDark.appTextColor
                    : AppColorsLight.appTextColor,
                isEllipsisTextOverflow: true,
                maxLines: 1,
              ),
              if (giftProduct.oldPrice != null)
                TextInAppWidget(
                  text: "${giftProduct.oldPrice} ${LocaleKeys.home_egp.tr()}",
                  textSize: 12,
                  fontWeightIndex: FontSelectionData.regularFontFamily,
                  textColor: isDark
                      ? AppColorsDark.mainColor
                      : AppColorsLight.mainColor,
                  textDecoration: TextDecoration.lineThrough,
                  decorationColor: isDark
                      ? AppColorsDark.mainColor
                      : AppColorsLight.mainColor,
                  isEllipsisTextOverflow: true,
                  maxLines: 1,
                ),
            ],
          ),
        ],
      ),
    );
  }
}
