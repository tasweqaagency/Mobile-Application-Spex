import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spex/core/helpers/extentions/extentions.dart';
import 'package:spex/core/routing/routing.dart';
import 'package:spex/feature/home/presentation/widgets/my_appbar.dart';
import 'package:spex/feature/home/presentation/widgets/product_card.dart';
import 'package:spex/generated/locale_keys.g.dart';
import 'package:spex/feature/favorite/view_model/favorite_cubit.dart';
import 'package:spex/feature/favorite/view_model/favorite_state.dart';
import 'package:spex/core/helpers/colors/light_colors.dart';
import 'package:spex/core/widgets/text_in_app_widget.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBarWithBackButton(
        title: LocaleKeys.home_favorite.tr(),
        showSearch: false,
      ),
      body: BlocBuilder<FavoriteCubit, FavoriteState>(
        builder: (context, state) {
          if (state is FavoriteLoading) {
            return const Center(
              child: CircularProgressIndicator(color: AppColorsLight.mainColor),
            );
          } else if (state is FavoriteError) {
            return Center(child: TextInAppWidget(text: state.message));
          } else if (state is FavoriteLoaded) {
            if (state.favorites.isEmpty) {
              return Center(
                child: TextInAppWidget(
                  text: LocaleKeys.home_no_fav_found.tr(),
                  textSize: 18,
                ),
              );
            }
            return GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.65,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: state.favorites.length,
              itemBuilder: (context, index) {
                final product = state.favorites[index];
                return InkWell(
                  onTap: () {
                    context.pushNamed(
                      Routes.productDetailsScreen,
                      arguments: product.id,
                    );
                  },
                  child: ProductCard(product: product),
                );
              },
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
