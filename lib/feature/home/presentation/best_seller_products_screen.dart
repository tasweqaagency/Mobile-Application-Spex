import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spex/core/helpers/colors/dark_colors.dart';
import 'package:spex/core/helpers/colors/light_colors.dart';
import 'package:spex/core/helpers/constants/constants.dart';
import 'package:spex/core/helpers/extentions/extentions.dart';
import 'package:spex/core/routing/routing.dart';
import 'package:spex/core/widgets/custom_pagination_widget.dart';
import 'package:spex/core/widgets/text_in_app_widget.dart';
import 'package:spex/feature/category/model/category_model.dart';
import 'package:spex/feature/category/view_model/category_products_cubit/category_products_cubit.dart';
import 'package:spex/feature/category/view_model/category_products_cubit/category_products_state.dart';
import 'package:spex/feature/home/presentation/widgets/product_card.dart';
import 'package:spex/feature/home/view_model/best_seller_cubit/best_seller_cubit.dart';
import 'package:spex/feature/home/view_model/best_seller_cubit/best_seller_state.dart';
import 'package:spex/generated/locale_keys.g.dart';
import 'package:spex/main.dart';

class BestSellerProductsScreen extends StatefulWidget {
  const BestSellerProductsScreen({super.key});

  @override
  State<BestSellerProductsScreen> createState() =>
      _BestSellerProductsScreenState();
}

class _BestSellerProductsScreenState extends State<BestSellerProductsScreen> {
  int _currentPage = 1;

  // @override
  // void initState() {
  //   super.initState();
  //   context.read<CategoryProductsCubit>().getCategoryProducts(
  //     widget.category.id,
  //     page: _currentPage,
  //   );
  // }

  void _onPageChanged(int page) {
    setState(() {
      _currentPage = page;
    });
    context.read<BestSellerCubit>().getBestSellers(page: _currentPage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextInAppWidget(
          text: LocaleKeys.home_best_seller.tr(),
          textSize: 18,
          fontWeightIndex: FontSelectionData.boldFontFamily,
          textColor: isDark
              ? AppColorsDark.appTextColor
              : AppColorsLight.appTextColor,
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: isDark
                ? AppColorsLight.whiteColor
                : AppColorsLight.blackColor,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: BlocBuilder<BestSellerCubit, BestSellerState>(
        builder: (context, state) {
          if (state is BestSellerLoadingState) {
            return const Center(
              child: CircularProgressIndicator(color: AppColorsLight.mainColor),
            );
          } else if (state is BestSellerLoadedState) {
            final paginationResult = state.products;
            final items = paginationResult.items ?? [];
            final totalPages = paginationResult.totalPages ?? 1;

            if (items.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.shopping_bag_outlined,
                      size: 64,
                      color: AppColorsLight.appSecondTextColor,
                    ),
                    const SizedBox(height: 16),
                    TextInAppWidget(
                      text: LocaleKeys.api_replay_message_request_not_found
                          .tr(),
                      textColor: AppColorsLight.appSecondTextColor,
                    ),
                  ],
                ),
              );
            }

            return Column(
              children: [
                Expanded(
                  child: GridView.builder(
                    padding: const EdgeInsets.all(16),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: context.isMobile ? 2 : 3,
                      childAspectRatio: 0.65,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                    ),
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final item = items[index];
                      return InkWell(
                        onTap: () {
                          context.pushNamed(
                            Routes.productDetailsScreen,
                            arguments: item.toSimplifiedProduct(),
                          );
                        },
                        child: ProductCard(product: item.toSimplifiedProduct()),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: CustomPaginationWidget(
                    currentPage: _currentPage,
                    totalPages: totalPages,
                    onPageChanged: _onPageChanged,
                  ),
                ),
              ],
            );
          } else if (state is BestSellerErrorState) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 48, color: Colors.red),
                  const SizedBox(height: 16),
                  TextInAppWidget(
                    text: state.errorMessage,
                    textColor: AppColorsLight.appSecondTextColor,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => context
                        .read<BestSellerCubit>()
                        .getBestSellers(page: _currentPage),
                    child: Text(LocaleKeys.api_replay_message_bad_request.tr()),
                  ),
                ],
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
