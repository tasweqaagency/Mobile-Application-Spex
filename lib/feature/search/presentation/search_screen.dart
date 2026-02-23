import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:spex/core/helpers/extentions/extentions.dart';
import 'package:spex/core/routing/routing.dart';
import 'package:spex/feature/home/model/home_mock_data.dart';
import 'package:spex/feature/home/presentation/widgets/my_appbar.dart';
import 'package:spex/feature/search/presentation/widgets/search_product_item.dart';
import 'package:spex/generated/locale_keys.g.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBarWithBackButton(
        title: LocaleKeys.home_search.tr(),
        isRealSearch: true,
        isAutoFocus: true,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: HomeMockData.bestOffers.length,
        separatorBuilder: (context, index) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          return SearchProductItem(
            product: HomeMockData.bestOffers[index],
            onTap: () {
              context.pushNamed(
                Routes.productDetailsScreen,
                arguments: HomeMockData.bestOffers[index],
              );
            },
          );
        },
      ),
    );
  }
}
