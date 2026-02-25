import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:spex/core/helpers/colors/dark_colors.dart';
import 'package:spex/core/helpers/colors/light_colors.dart';
import 'package:spex/core/widgets/text_in_app_widget.dart';
import 'package:spex/feature/home/presentation/widgets/my_appbar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spex/core/di/sl.dart';
import 'package:spex/feature/search/view_model/search_cubit/search_cubit.dart';
import 'package:spex/feature/search/presentation/widgets/search_product_item.dart';
import 'package:spex/generated/locale_keys.g.dart';
import 'package:spex/main.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<SearchCubit>(),
      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: MyAppBarWithBackButton(
              title: LocaleKeys.home_search.tr(),
              isRealSearch: true,
              isAutoFocus: true,
              onChanged: (value) {
                context.read<SearchCubit>().search(value);
              },
            ),
            body: BlocBuilder<SearchCubit, SearchState>(
              builder: (context, state) {
                if (state is SearchLoadingState) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is SearchErrorState) {
                  return Center(child: TextInAppWidget(text: state.errorMessage.tr(), textColor: isDark ? AppColorsDark.appTextColor : AppColorsLight.appTextColor));
                } else if (state is SearchSuccessState) {
                  if (state.searchItems.isEmpty) {
                    return Center(child: Text(LocaleKeys.home_search.tr()));
                  }
                  return ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: state.searchItems.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final item = state.searchItems[index];
                      return SearchProductItem(
                        product: item,
                        onTap: () {
                          // Handle product details navigation when Search API provides needed data.
                        },
                      );
                    },
                  );
                }
                return Center(child: Text(LocaleKeys.home_search.tr()));
              },
            ),
          );
        },
      ),
    );
  }
}
