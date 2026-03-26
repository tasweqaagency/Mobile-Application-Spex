import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:spex/core/helpers/colors/dark_colors.dart';
import 'package:spex/core/helpers/colors/light_colors.dart';
import 'package:spex/core/helpers/constants/constants.dart';
import 'package:spex/core/helpers/extentions/extentions.dart';
import 'package:spex/core/widgets/snakbar.dart';
import 'package:spex/core/widgets/text_in_app_widget.dart';
import 'package:spex/feature/home/model/product_model.dart';
import 'package:spex/feature/home/presentation/widgets/product_icon_botton_widget.dart';
import 'package:spex/feature/home/presentation/widgets/product_image_widget.dart';
import 'package:spex/feature/home/presentation/widgets/product_label_flag_widget.dart';
import 'package:spex/feature/home/presentation/widgets/product_rating_widget.dart';
import 'package:spex/generated/locale_keys.g.dart';
import 'package:spex/main.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spex/feature/favorite/view_model/favorite_cubit.dart';
import 'package:spex/feature/favorite/view_model/favorite_state.dart';
import 'package:spex/feature/compare/view_model/compare_cubit.dart';
import 'package:spex/feature/compare/view_model/compare_state.dart';
import 'package:spex/feature/cart/view_model/cart_cubit.dart';
import 'package:spex/feature/cart/model/cart_item.dart';
import 'package:spex/feature/product_details/model/mini_product_model.dart';
import 'package:spex/feature/product_details/presentation/widgets/variation_selection_dialog.dart';

class ProductCard extends StatelessWidget {
  final SimplifiedProductModel product;

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
              ProductImageWidget(imageUrl: product.galleryImages),
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
                    BlocBuilder<FavoriteCubit, FavoriteState>(
                      builder: (context, state) {
                        bool isFavorite = false;
                        if (state is FavoriteLoaded) {
                          isFavorite = state.favorites.any(
                            (e) => e.id == product.id,
                          );
                        }
                        return ProductIconBottonWidget(
                          icon: isFavorite
                              ? Icons.favorite
                              : Icons.favorite_border,
                          onTap: () {
                            context.read<FavoriteCubit>().toggleFavorite(
                              product,
                            );
                          },
                          color: isFavorite
                              ? AppColorsLight.appDarkRedColor
                              : AppColorsLight.whiteColor,
                        );
                      },
                    ),
                    BlocBuilder<CompareCubit, CompareState>(
                      builder: (context, state) {
                        bool isInCompare = false;
                        if (state is CompareLoaded) {
                          isInCompare = state.products.any(
                            (e) => e.id == product.id,
                          );
                        }
                        return ProductIconBottonWidget(
                          icon: Icons.swap_horiz_outlined,
                          onTap: () {
                            context.read<CompareCubit>().toggleCompare(product);
                          },
                          color: isInCompare
                              ? AppColorsLight.mainColor
                              : AppColorsLight.whiteColor,
                        );
                      },
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 2,
                right: 2,
                child: InkWell(
                  onTap: () => _handleAddToCart(context, product),
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

  void _handleAddToCart(BuildContext context, SimplifiedProductModel product) async {
    bool hasVariations = product.variations != null && product.variations!.isNotEmpty;
    bool hasColorOrSize = product.colors.isNotEmpty || product.availableSizes.isNotEmpty;

    if (hasVariations || hasColorOrSize) {
      // Show variation selection dialog
      final result = await showDialog<Map<String, dynamic>>(
        context: context,
        builder: (context) => VariationSelectionDialog(product: product),
      );

      if (result != null) {
        final selectedVariation = result['variation'] as Variations?;
        final selectedColorObj = result['color'] as Color?;
        final selectedSize = result['size'] as String?;

        // 🚨 STOCK CHECK: Variations
        if (selectedVariation != null && selectedVariation.stockStatus != StockStatus.instock.name) {
          AppSnackBar.showError(LocaleKeys.home_out_of_stock.tr());
          return;
        }

        String? colorLabel;
        if (selectedColorObj != null) {
          int index = product.colors.indexOf(selectedColorObj);
          if (index != -1 && index < product.colorNames.length) {
            colorLabel = product.colorNames[index];
          }
        }

        final cartItem = product.toCartItem(
          selectedVariation: selectedVariation,
          forcedColor: colorLabel,
          forcedSize: selectedSize,
        );

        if (context.mounted) {
          context.read<CartCubit>().addToCart(cartItem);
          AppSnackBar.showSuccess(LocaleKeys.cart_added_to_cart_success.tr());
        }
      }
    } else {
      // Simple product
      // 🚨 STOCK CHECK: Simple Product
      if (!product.inStock) {
        AppSnackBar.showError(LocaleKeys.home_out_of_stock.tr());
        return;
      }

      final cartItem = product.toCartItem();
      if (context.mounted) {
        context.read<CartCubit>().addToCart(cartItem);
        AppSnackBar.showSuccess(LocaleKeys.cart_added_to_cart_success.tr());
      }
    }
  }


}
