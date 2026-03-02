import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spex/core/helpers/colors/light_colors.dart';
import 'package:spex/core/helpers/constants/constants.dart';
import 'package:spex/core/routing/routing.dart';
import 'package:spex/core/widgets/text_in_app_widget.dart';
import 'package:spex/feature/home/model/home_mock_data.dart';
import 'package:spex/feature/home/presentation/widgets/my_appbar.dart';
import 'package:spex/feature/home/presentation/widgets/product_card.dart';
import 'package:spex/feature/home/presentation/widgets/product_icon_botton_widget.dart';
import 'package:spex/feature/home/presentation/widgets/product_rating_widget.dart';
import 'package:spex/feature/home/presentation/widgets/section_header.dart';
import 'package:spex/core/helpers/extentions/extentions.dart';
import 'package:spex/feature/product_details/presentation/widgets/icon_box.dart';
import 'package:spex/feature/product_details/presentation/widgets/product_details_banner.dart';
import 'package:spex/feature/product_details/presentation/widgets/product_details_tapbar.dart';
import 'package:spex/feature/product_details/presentation/widgets/product_gift_widget.dart';
import 'package:spex/feature/product_details/presentation/widgets/product_services_widget.dart';
import 'package:spex/generated/locale_keys.g.dart';
import 'package:spex/main.dart';
import '../../../core/helpers/colors/dark_colors.dart';
import '../../home/model/product_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spex/feature/product_details/view_model/product_details_cubit.dart';
import 'package:spex/feature/product_details/view_model/product_details_state.dart';
import 'package:spex/feature/favorite/view_model/favorite_cubit.dart';
import 'package:spex/feature/favorite/view_model/favorite_state.dart';
import 'package:spex/feature/compare/view_model/compare_cubit.dart';
import 'package:spex/feature/compare/view_model/compare_state.dart';

class ProductDetailsScreen extends StatelessWidget {
  final SimplifiedProductModel product;
  const ProductDetailsScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
      builder: (context, state) {
        final currentProduct = state is ProductDetailsLoadedState
            ? state.product
            : product;

        return Scaffold(
          appBar: MyAppBarWithBackButton(title: currentProduct.name),
          body: SafeArea(
            child: Stack(
              children: [
                if (state is ProductDetailsLoadingState)
                  const LinearProgressIndicator(
                    color: AppColorsLight.mainColor,
                  ),
                SingleChildScrollView(
                  child: Column(
                    children: [
                      SvgPicture.asset(
                        "assets/images/final-mob.svg",
                        height: 60,
                        width: double.infinity,
                        fit: BoxFit.fill,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 10,
                          children: [
                            ProductDetailsBanner(product: currentProduct),
                            Row(
                              spacing: 10,
                              children: [
                                TextInAppWidget(
                                  text: currentProduct.category,
                                  textColor: isDark
                                      ? AppColorsDark.appSecondTextColor
                                      : AppColorsLight.appSecondTextColor,
                                  textSize: 14,
                                  maxLines: 1,
                                  fontWeightIndex:
                                      FontSelectionData.regularFontFamily,
                                  isEllipsisTextOverflow: true,
                                ),
                                const Spacer(),
                                BlocBuilder<FavoriteCubit, FavoriteState>(
                                  builder: (context, state) {
                                    bool isFavorite = false;
                                    if (state is FavoriteLoaded) {
                                      isFavorite = state.favorites.any(
                                        (e) => e.id == currentProduct.id,
                                      );
                                    }
                                    return ProductIconBottonWidget(
                                      icon: isFavorite
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      onTap: () {
                                        context
                                            .read<FavoriteCubit>()
                                            .toggleFavorite(currentProduct);
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
                                        (e) => e.id == currentProduct.id,
                                      );
                                    }
                                    return ProductIconBottonWidget(
                                      icon: Icons.swap_horiz_outlined,
                                      onTap: () {
                                        context
                                            .read<CompareCubit>()
                                            .toggleCompare(currentProduct);
                                      },
                                      color: isInCompare
                                          ? AppColorsLight.mainColor
                                          : AppColorsLight.whiteColor,
                                    );
                                  },
                                ),
                                ProductIconBottonWidget(
                                  icon: Icons.ios_share_outlined,
                                  onTap: () {},
                                  color: AppColorsLight.whiteColor,
                                ),
                              ],
                            ),
                            TextInAppWidget(
                              text: currentProduct.name,
                              textColor: isDark
                                  ? AppColorsDark.appTextColor
                                  : AppColorsLight.appTextColor,
                              textSize: 17,
                              maxLines: 3,
                              fontWeightIndex: FontSelectionData.boldFontFamily,
                              isEllipsisTextOverflow: true,
                            ),
                            ProductRatingWidget(rating: currentProduct.rating),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                if (currentProduct.oldPrice != null) ...[
                                  Flexible(
                                    child: TextInAppWidget(
                                      text:
                                          '${currentProduct.regularPrice} ${LocaleKeys.home_egp.tr()}',
                                      textSize: 16,
                                      textColor: isDark
                                          ? AppColorsDark.appSecondTextColor
                                          : AppColorsLight.appSecondTextColor,
                                      isEllipsisTextOverflow: true,
                                      maxLines: 1,
                                      fontWeightIndex:
                                          FontSelectionData.regularFontFamily,
                                      textDecoration:
                                          TextDecoration.lineThrough,
                                      decorationColor: AppColorsLight.mainColor,
                                      decorationThickness: 1.0,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                ],
                                Flexible(
                                  child: TextInAppWidget(
                                    text:
                                        '${currentProduct.price} ${LocaleKeys.home_egp.tr()}',
                                    textSize: 18,
                                    fontWeightIndex:
                                        FontSelectionData.boldFontFamily,
                                    textColor: isDark
                                        ? AppColorsDark.mainColor
                                        : AppColorsLight.mainColor,
                                    isEllipsisTextOverflow: true,
                                    maxLines: 1,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                currentProduct.inStock
                                    ? Row(
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
                                            fontWeightIndex: FontSelectionData
                                                .boldFontFamily,
                                            textColor: isDark
                                                ? AppColorsDark.greenColor2
                                                : AppColorsLight.greenColor2,
                                          ),
                                        ],
                                      )
                                    : TextInAppWidget(
                                        text: LocaleKeys.home_out_of_stock.tr(),
                                        textSize: 14,
                                        fontWeightIndex: FontSelectionData
                                            .semiBoldFontFamily,
                                        textColor: isDark
                                            ? AppColorsDark.appRedColor
                                            : AppColorsLight.appRedColor,
                                      ),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  spacing: 5,
                                  children: currentProduct.colors
                                      .map(
                                        (color) => Container(
                                          width: 20,
                                          height: 20,
                                          decoration: BoxDecoration(
                                            color: color,
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                              color: AppColorsDark.mainColor,
                                              width: 2,
                                            ),
                                          ),
                                        ),
                                      )
                                      .toList(),
                                ),
                              ],
                            ),
                            Divider(
                              color: isDark
                                  ? AppColorsDark.appSecondTextColor.withValues(
                                      alpha: 0.5,
                                    )
                                  : AppColorsLight.appSecondTextColor
                                        .withValues(alpha: 0.5),
                            ),
                            ProductGiftWidget(
                              giftProduct: HomeMockData.bestOffers[0]
                                  .toSimplified(),
                            ),
                            const SizedBox(height: 10),
                            SectionHeader(
                              title: LocaleKeys.product_details_recommended
                                  .tr(),
                            ),
                            const SizedBox(height: 5),
                            SizedBox(
                              height: context.screenWidth * 0.7,
                              child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                itemCount: HomeMockData.bestOffers.length,
                                separatorBuilder: (context, index) =>
                                    const SizedBox(width: 12),
                                itemBuilder: (context, index) {
                                  final item = HomeMockData.bestOffers[index]
                                      .toSimplified();
                                  return SizedBox(
                                    width: 180,
                                    child: InkWell(
                                      child: ProductCard(product: item),
                                      onTap: () {
                                        context.pushNamed(
                                          Routes.productDetailsScreen,
                                          arguments: item,
                                        );
                                      },
                                    ),
                                  );
                                },
                              ),
                            ),
                            const SizedBox(height: 10),
                            const ProductServicesWidget(),
                            ProductDetailsTapBar(product: currentProduct),
                            const SizedBox(height: 80),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 85,
                    padding: const EdgeInsets.all(15),
                    width: context.screenWidth,
                    decoration: BoxDecoration(
                      color: isDark
                          ? AppColorsDark.appSecondBgColor
                          : AppColorsLight.whiteColor,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextInAppWidget(
                              text: "total price",
                              textSize: 16,
                              fontWeightIndex:
                                  FontSelectionData.regularFontFamily,
                              textColor: isDark
                                  ? AppColorsDark.appSecondTextColor
                                  : AppColorsLight.appSecondTextColor,
                            ),
                            const SizedBox(height: 5),
                            TextInAppWidget(
                              text:
                                  "${currentProduct.price}${LocaleKeys.home_egp.tr()}",
                              textSize: 18,
                              fontWeightIndex: FontSelectionData.boldFontFamily,
                              textColor: isDark
                                  ? AppColorsDark.appTextColor
                                  : AppColorsLight.appTextColor,
                            ),
                          ],
                        ),
                        IconBox(
                          width: 55,
                          height: 55,
                          icon: Icons.shopping_cart_outlined,
                          onTap: () {},
                        ),
                        SizedBox(
                          width: context.screenWidth * 0.35,
                          height: 55,
                          child: MaterialButton(
                            onPressed: () {},
                            color: AppColorsDark.mainColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const TextInAppWidget(
                              text: "Buy Now",
                              textSize: 16,
                              fontWeightIndex: FontSelectionData.boldFontFamily,
                              textColor: AppColorsDark.appTextColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
