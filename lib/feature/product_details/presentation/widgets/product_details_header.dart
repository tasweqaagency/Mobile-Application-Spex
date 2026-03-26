import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_plus/share_plus.dart';
import 'package:spex/core/helpers/colors/dark_colors.dart';
import 'package:spex/core/helpers/colors/light_colors.dart';
import 'package:spex/core/helpers/constants/constants.dart';
import 'package:spex/core/widgets/text_in_app_widget.dart';
import 'package:spex/feature/compare/view_model/compare_cubit.dart';
import 'package:spex/feature/compare/view_model/compare_state.dart';
import 'package:spex/feature/favorite/view_model/favorite_cubit.dart';
import 'package:spex/feature/favorite/view_model/favorite_state.dart';
import 'package:spex/feature/home/model/product_model.dart';
import 'package:spex/feature/home/presentation/widgets/product_icon_botton_widget.dart';
import 'package:spex/feature/home/presentation/widgets/product_rating_widget.dart';
import 'package:spex/feature/product_details/presentation/widgets/product_details_banner.dart';
import 'package:spex/main.dart';

class ProductDetailsHeader extends StatelessWidget {
  final SimplifiedProductModel product;

  const ProductDetailsHeader({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ProductDetailsBanner(product: product),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: TextInAppWidget(
                text: product.category,
                textColor: isDark
                    ? AppColorsDark.appSecondTextColor
                    : AppColorsLight.appSecondTextColor,
                textSize: 14,
                maxLines: 1,
                fontWeightIndex: FontSelectionData.regularFontFamily,
                isEllipsisTextOverflow: true,
              ),
            ),
            BlocBuilder<FavoriteCubit, FavoriteState>(
              builder: (context, state) {
                bool isFavorite = false;
                if (state is FavoriteLoaded) {
                  isFavorite = state.favorites.any((e) => e.id == product.id);
                }
                return ProductIconBottonWidget(
                  icon: isFavorite ? Icons.favorite : Icons.favorite_border,
                  onTap: () {
                    context.read<FavoriteCubit>().toggleFavorite(product);
                  },
                  color: isFavorite
                      ? AppColorsLight.appDarkRedColor
                      : AppColorsLight.whiteColor,
                );
              },
            ),
            const SizedBox(width: 10),
            BlocBuilder<CompareCubit, CompareState>(
              builder: (context, state) {
                bool isInCompare = false;
                if (state is CompareLoaded) {
                  isInCompare = state.products.any((e) => e.id == product.id);
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
            const SizedBox(width: 10),
            ProductIconBottonWidget(
              icon: Icons.ios_share_outlined,
              onTap: () {
                Share.share(
                  '${product.name}\n${product.productUrl}',
                );
              },
              color: AppColorsLight.whiteColor,
            ),
          ],
        ),
        const SizedBox(height: 5),
        TextInAppWidget(
          text: product.name,
          textSize: 18,
          maxLines: 2,
          textColor:
              isDark ? AppColorsDark.appTextColor : AppColorsLight.appTextColor,
          fontWeightIndex: FontSelectionData.boldFontFamily,
          isEllipsisTextOverflow: true,
        ),
        const SizedBox(height: 5),
        ProductRatingWidget(rating: product.rating),
      ],
    );
  }
}
