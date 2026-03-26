import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spex/core/helpers/colors/dark_colors.dart';
import 'package:spex/core/helpers/colors/light_colors.dart';
import 'package:spex/core/helpers/constants/constants.dart';
import 'package:spex/core/helpers/extentions/extentions.dart';
import 'package:spex/core/routing/routing.dart';
import 'package:spex/core/widgets/snakbar.dart';
import 'package:spex/core/widgets/text_in_app_widget.dart';
import 'package:spex/feature/home/model/product_model.dart';
import 'package:spex/feature/home/presentation/widgets/my_appbar.dart';
import 'package:spex/feature/home/presentation/widgets/top_banners_widget.dart';
import 'package:spex/feature/product_details/presentation/widgets/product_color_widget.dart';
import 'package:spex/feature/product_details/presentation/widgets/product_size_widget.dart';
import 'package:spex/feature/product_details/presentation/widgets/product_gift_widget.dart';
import 'package:spex/feature/product_details/presentation/widgets/product_services_widget.dart';
import 'package:spex/feature/product_details/presentation/widgets/product_details_tapbar.dart';
import 'package:spex/feature/home/presentation/widgets/product_card.dart';
import 'package:spex/feature/home/presentation/widgets/section_header.dart';
import 'package:spex/main.dart';
import 'package:spex/feature/product_details/view_model/product_details_cubit.dart';
import 'package:spex/feature/product_details/view_model/product_details_state.dart';
import 'package:spex/feature/cart/view_model/cart_cubit.dart';
import 'package:spex/feature/product_details/presentation/widgets/variation_selection_dialog.dart';
import 'package:spex/feature/product_details/model/mini_product_model.dart';
import 'package:spex/generated/locale_keys.g.dart';
import 'package:spex/feature/product_details/presentation/widgets/icon_box.dart';
import 'package:spex/feature/product_details/presentation/widgets/product_details_header.dart';
import 'package:spex/feature/product_details/presentation/widgets/product_price_and_stock.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
      builder: (context, state) {
        if (state is! ProductDetailsLoadedState) {
          return const Scaffold(
            appBar: MyAppBarWithBackButton(title: ''),
            body: Center(
              child: CircularProgressIndicator(color: AppColorsLight.mainColor),
            ),
          );
        }

        final currentProduct = state.product;

        // Drive dynamic display from cubit state
        final matchedVariation = state.matchedVariation;
        final selectedColor = state.selectedColor;
        final selectedSize = state.selectedSize;


        final displayPrice = matchedVariation?.price ?? currentProduct.price;
        final displayOldPrice =
            matchedVariation?.regularPrice ?? currentProduct.regularPrice;

        bool isInStock;
        if (currentProduct.variations != null &&
            currentProduct.variations!.isNotEmpty) {
          isInStock = matchedVariation?.stockStatus == StockStatus.instock.name;
        } else {
          isInStock = currentProduct.inStock;
        }

        return Scaffold(
          appBar: MyAppBarWithBackButton(title: currentProduct.name),
          body: SafeArea(
            child: Stack(
              children: [
                if (state.isRefreshing)
                  const LinearProgressIndicator(
                    color: AppColorsLight.mainColor,
                  ),
                SingleChildScrollView(
                  child: Column(
                    children: [
                      const TopBannersWidget(),
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ProductDetailsHeader(product: currentProduct),
                            const SizedBox(height: 10),
                            ProductPriceAndStock(
                              displayPrice: displayPrice,
                              displayOldPrice: displayOldPrice,
                              isInStock: isInStock,
                            ),
                            const SizedBox(height: 10),
                            Wrap(
                              spacing: 20,
                              runSpacing: 15,
                              children: [
                                if (currentProduct.colors.isNotEmpty)
                                  ProductColorWidget(
                                    colors: currentProduct.colors,
                                    selectedColor: selectedColor,
                                    onColorSelected: (color) {
                                      context
                                          .read<ProductDetailsCubit>()
                                          .selectColor(color);
                                    },
                                  ),
                                if (currentProduct.availableSizes.isNotEmpty)
                                  ProductSizeWidget(
                                    sizes: currentProduct.availableSizes,
                                    selectedSize: selectedSize,
                                    onSizeSelected: (size) {
                                      context
                                          .read<ProductDetailsCubit>()
                                          .selectSize(size);
                                    },
                                  ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Divider(
                              color: isDark
                                  ? AppColorsDark.appSecondTextColor.withValues(
                                      alpha: 0.5,
                                    )
                                  : AppColorsLight.appSecondTextColor
                                      .withValues(alpha: 0.5),
                            ),
                            if (state.giftProducts.isNotEmpty)
                              ...state.giftProducts.map(
                                (gp) => ProductGiftWidget(giftProduct: gp),
                              ),
                            const SizedBox(height: 10),
                            if (state.fbtProducts.isNotEmpty) ...[
                              SectionHeader(
                                title: LocaleKeys
                                    .product_details_frequently_bought_together
                                    .tr(),
                              ),
                              const SizedBox(height: 5),
                              SizedBox(
                                height: 260,
                                child: ListView.separated(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: state.fbtProducts.length,
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(width: 12),
                                  itemBuilder: (context, index) {
                                    final item = state.fbtProducts[index];
                                    return SizedBox(
                                      width: 180,
                                      child: InkWell(
                                        child: ProductCard(product: item),
                                        onTap: () {
                                          Navigation(context).pushNamed(
                                            Routes.productDetailsScreen,
                                            arguments: item,
                                          );
                                        },
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                            const SizedBox(height: 10),
                            const ProductServicesWidget(),
                            ProductDetailsTapBar(product: currentProduct),
                            const SizedBox(height: 100),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                ProductDetailsBottomBar(
                  displayPrice: displayPrice,
                  onAddToCart: () => _handleAddToCart(context, currentProduct),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _handleAddToCart(
    BuildContext context,
    SimplifiedProductModel product,
  ) async {
    final state = context.read<ProductDetailsCubit>().state;
    if (state is! ProductDetailsLoadedState) return;

    final selectedColor = state.selectedColor;
    final selectedSize = state.selectedSize;
    final matchedVariation = state.matchedVariation;

    bool hasVariations =
        product.variations != null && product.variations!.isNotEmpty;
    bool hasColorOrSize =
        product.colors.isNotEmpty || product.availableSizes.isNotEmpty;

    bool selectionComplete = true;
    if (product.colors.isNotEmpty && selectedColor == null) {
      selectionComplete = false;
    }
    if (product.availableSizes.isNotEmpty && selectedSize == null) {
      selectionComplete = false;
    }
    if (hasVariations && matchedVariation == null) {
      selectionComplete = false;
    }

    if (selectionComplete && (hasVariations || hasColorOrSize)) {
      if (hasVariations &&
          matchedVariation != null &&
          matchedVariation.stockStatus != StockStatus.instock.name) {
        AppSnackBar.showError(LocaleKeys.home_out_of_stock.tr());
        return;
      } else if (!hasVariations && !product.inStock) {
        AppSnackBar.showError(LocaleKeys.home_out_of_stock.tr());
        return;
      }

      String? colorLabel;
      if (selectedColor != null) {
        int index = product.colors.indexOf(selectedColor);
        if (index != -1 && index < product.colorNames.length) {
          colorLabel = product.colorNames[index];
        }
      }

      final cartItem = product.toCartItem(
        selectedVariation: matchedVariation,
        forcedColor: colorLabel,
        forcedSize: selectedSize,
      );

      context.read<CartCubit>().addToCart(cartItem);
      AppSnackBar.showSuccess(LocaleKeys.cart_added_to_cart_success.tr());
      return;
    }

    if (hasVariations || hasColorOrSize) {
      final result = await showDialog<Map<String, dynamic>>(
        context: context,
        builder: (context) => VariationSelectionDialog(product: product),
      );

      if (result != null) {
        final selectedVariation = result['variation'] as Variations?;
        final selectedColorObj = result['color'] as Color?;
        final selectedSizeRes = result['size'] as String?;

        if (selectedVariation != null &&
            selectedVariation.stockStatus != StockStatus.instock.name) {
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
          forcedSize: selectedSizeRes,
        );

        if (context.mounted) {
          context.read<CartCubit>().addToCart(cartItem);
          AppSnackBar.showSuccess(LocaleKeys.cart_added_to_cart_success.tr());
        }
      }
    } else {
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

class ProductDetailsBottomBar extends StatelessWidget {
  final String displayPrice;
  final VoidCallback onAddToCart;

  const ProductDetailsBottomBar({
    super.key,
    required this.displayPrice,
    required this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 15,
        ),
        decoration: BoxDecoration(
          color: isDark ? AppColorsDark.appSecondBgColor : AppColorsLight.whiteColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextInAppWidget(
                  text: LocaleKeys.product_details_total_price.tr(),
                  textSize: 12,
                  textColor: isDark
                      ? AppColorsDark.appSecondTextColor
                      : AppColorsLight.appSecondTextColor,
                ),
                TextInAppWidget(
                  text: '$displayPrice ${LocaleKeys.home_egp.tr()}',
                  textSize: 20,
                  fontWeightIndex: FontSelectionData.boldFontFamily,
                  textColor: isDark ? AppColorsDark.mainColor : AppColorsLight.mainColor,
                ),
              ],
            ),
            IconBox(
              width: 55,
              height: 55,
              icon: Icons.shopping_cart_outlined,
              onTap: onAddToCart,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.35,
              height: 55,
              child: MaterialButton(
                onPressed: onAddToCart,
                color: AppColorsDark.mainColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TextInAppWidget(
                  text: LocaleKeys.product_details_buy_now.tr(),
                  textSize: 16,
                  fontWeightIndex: FontSelectionData.boldFontFamily,
                  textColor: AppColorsDark.appTextColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
