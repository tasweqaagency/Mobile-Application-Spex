import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:spex/core/helpers/extentions/extentions.dart';
import 'package:spex/core/routing/routing.dart';
import 'package:spex/feature/home/model/home_mock_data.dart';
import 'package:spex/feature/home/presentation/widgets/my_appbar.dart';
import 'package:spex/feature/home/presentation/widgets/product_card.dart';
import 'package:spex/generated/locale_keys.g.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBarWithBackButton(
        title: LocaleKeys.home_favorite.tr(),
        showSearch: false,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.65,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemCount: HomeMockData.bestOffers.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              context.pushNamed(
                Routes.productDetailsScreen,
                arguments: HomeMockData.bestOffers[index],
              );
            },
            child: ProductCard(product: HomeMockData.bestOffers[index]),
          );
        },
      ),
    );
  }
}
