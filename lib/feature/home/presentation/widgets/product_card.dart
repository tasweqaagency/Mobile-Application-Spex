import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:spex/core/helpers/colors/dark_colors.dart';
import 'package:spex/core/helpers/colors/light_colors.dart';
import 'package:spex/core/helpers/constants/constants.dart';
import 'package:spex/core/widgets/text_in_app_widget.dart';
import 'package:spex/feature/home/model/product_model.dart';
import 'package:spex/feature/home/presentation/widgets/product_icon_botton_widget.dart';
import 'package:spex/feature/home/presentation/widgets/product_image_widget.dart';
import 'package:spex/feature/home/presentation/widgets/product_label_flag_widget.dart';
import 'package:spex/feature/home/presentation/widgets/product_rating_widget.dart';
import 'package:spex/generated/locale_keys.g.dart';
import 'package:spex/main.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isDark
            ? AppColorsDark.appSecondBgColor
            : AppColorsLight.whiteColor,
        borderRadius: BorderRadius.circular(16),
        // boxShadow: [
        //   BoxShadow(
        //     color: AppColorsLight.black50Color.withValues(alpha: 0.05),
        //     blurRadius: 10,
        //     offset: const Offset(0, 5),
        //   ),
        // ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,

        children: [
          Stack(
            children: [
              ProductImageWidget(imageUrl: product.imagePath),
              if (product.isHot)
                Positioned(
                  top: 10,
                  left: 10,
                  child: ProductLabelFlagWidget(
                    text: LocaleKeys.home_hot.tr(),
                    color: AppColorsLight.appRedColor,
                  ),
                ),

              if (product.isNew)
                Positioned(
                  top: 10,
                  left: 10,
                  child: ProductLabelFlagWidget(
                    text: LocaleKeys.home_new.tr(),
                    color: AppColorsLight.mainAccentColor,
                  ),
                ),

              Positioned(
                top: 10,
                right: 10,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  spacing: 12,
                  children: [
                    ProductIconBottonWidget(
                      icon: product.isFavorite
                          ? Icons.favorite
                          : Icons.favorite_border,
                      onTap: () {},
                      color: product.isFavorite
                          ? AppColorsLight.appDarkRedColor
                          : AppColorsLight.whiteColor,
                    ),
                    ProductIconBottonWidget(
                      icon: Icons.swap_horiz_outlined,
                      onTap: () {},
                      color: AppColorsLight.whiteColor,
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 2,
                right: 2,
                child: InkWell(
                  onTap: () {},
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: isDark
                        ? AppColorsDark.mainColor
                        : AppColorsLight.mainColor,
                    child: Center(
                      child: Icon(
                        Icons.shopping_cart_outlined,
                        color: AppColorsLight.whiteColor,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 10,
                left: 10,
                child: OneStarProductRatingWidget(rating: product.rating),
              ),
              // Positioned(
              //   bottom: 5,
              //   right: 5,
              //   child: CircleAvatar(
              //     radius: 18,
              //     backgroundColor: AppColorsLight.mainColor,
              //     child: IconButton(
              //       color: AppColorsLight.whiteColor,
              //       icon: Icon(
              //         Icons.shopping_cart_outlined,
              //         size: 20,
              //       ),
              //       onPressed: () {},
              //     ),
              //   ),
              // ),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(12),
            child: Column(
              spacing: 8,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // TextInAppWidget(
                //   text: product.category,
                //   textSize: 12,
                //   fontWeightIndex: FontSelectionData.semiBoldFontFamily,
                //   textColor: isDark
                //       ? AppColorsDark.appSecondTextColor
                //       : AppColorsLight.appSecondTextColor,
                //   isEllipsisTextOverflow: true,
                //   maxLines: 1,
                // ),
                TextInAppWidget(
                  text: product.name,
                  textSize: 14,
                  fontWeightIndex: FontSelectionData.semiBoldFontFamily,
                  textColor: isDark
                      ? AppColorsDark.appTextColor
                      : AppColorsLight.appTextColor,
                  isEllipsisTextOverflow: true,
                  maxLines: 2,
                ),
                product.inStock
                    ? Row(
                        children: [
                          Icon(
                            Icons.check,
                            color: AppColorsDark.mainColor,
                            size: 18,
                          ),
                          SizedBox(width: 4),
                          TextInAppWidget(
                            text: LocaleKeys.home_in_stock.tr(),
                            textSize: 14,
                            fontWeightIndex:
                                FontSelectionData.semiBoldFontFamily,
                            textColor: isDark
                                ? AppColorsDark.appTextColor
                                : AppColorsLight.appTextColor,
                          ),
                        ],
                      )
                    : TextInAppWidget(
                        text: LocaleKeys.home_out_of_stock.tr(),
                        textSize: 14,
                        fontWeightIndex: FontSelectionData.semiBoldFontFamily,
                        textColor: isDark
                            ? AppColorsDark.appRedColor
                            : AppColorsLight.appRedColor,
                      ),
                Wrap(
                  spacing: 5,
                  runSpacing: 5,
                  children: [
                    TextInAppWidget(
                      text: '${product.price} ${LocaleKeys.home_egp.tr()}',
                      textSize: 16,
                      fontWeightIndex: FontSelectionData.boldFontFamily,
                      textColor: isDark
                          ? AppColorsDark.mainColor
                          : AppColorsLight.mainColor,
                      isEllipsisTextOverflow: true,
                      maxLines: 1,
                    ),
                    if (product.oldPrice != null) ...[
                      SizedBox(width: 8),
                      TextInAppWidget(
                        text: '${product.oldPrice} ${LocaleKeys.home_egp.tr()}',
                        textSize: 14,
                        textColor: isDark
                            ? AppColorsDark.appSecondTextColor
                            : AppColorsLight.appSecondTextColor,
                        isEllipsisTextOverflow: true,
                        maxLines: 1,
                        textDecoration: TextDecoration.lineThrough,
                        decorationColor: AppColorsLight.mainColor,
                        decorationThickness: 1.0,
                      ),
                    ],
                  ],
                ),
                // SizedBox(height: 4),

                // Row(
                //   spacing: 4,
                //   children: product.colors
                //       .map(
                //         (color) => Flexible(
                //           child: Container(
                //             width: 16,
                //             height: 16,
                //             decoration: BoxDecoration(
                //               color: color,
                //               shape: BoxShape.circle,
                //             ),
                //           ),
                //         ),
                //       )
                //       .toList(),
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
