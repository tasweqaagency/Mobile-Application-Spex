import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spex/core/helpers/colors/dark_colors.dart';
import 'package:spex/core/helpers/colors/light_colors.dart';
import 'package:spex/core/helpers/extentions/extentions.dart';
import 'package:spex/core/routing/routing.dart';
import 'package:spex/core/widgets/text_in_app_widget.dart';
import 'package:spex/feature/home/presentation/widgets/my_appbar.dart';
import 'package:spex/feature/home/presentation/widgets/product_card.dart';
import 'package:spex/feature/home/view_model/promotions_cubit/promotions_cubit.dart';
import 'package:spex/feature/home/view_model/promotions_cubit/promotions_state.dart';
import 'package:spex/main.dart';

class PromosionScreen extends StatelessWidget {
  const PromosionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBarWithLogo(),
      body: BlocBuilder<PromotionsCubit, PromotionsState>(
        builder: (context, state) {
          if (state is PromotionsLoadingState) {
            return const Center(
              child: CircularProgressIndicator(color: AppColorsLight.mainColor),
            );
          } else if (state is PromotionsLoadedState) {
            return GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.65,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: state.products.length,
              itemBuilder: (context, index) {
                final product = state.products[index];
                return InkWell(
                  onTap: () {
                    context.pushNamed(
                      Routes.productDetailsScreen,
                      arguments: product,
                    );
                  },
                  child: ProductCard(product: product),
                );
              },
            );
          } else if (state is PromotionsErrorState) {
            return Center(
              child: TextInAppWidget(
                text: state.errorMessage,
                textColor: isDark
                    ? AppColorsDark.appTextColor
                    : AppColorsLight.appTextColor,
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
