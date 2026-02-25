import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spex/core/helpers/colors/dark_colors.dart';
import 'package:spex/core/helpers/colors/light_colors.dart';
import 'package:spex/core/helpers/constants/constants.dart';
import 'package:spex/core/helpers/extentions/extentions.dart';
import 'package:spex/core/routing/routing.dart';
import 'package:spex/core/widgets/text_in_app_widget.dart';
import 'package:spex/feature/home/model/home_mock_data.dart';
import 'package:spex/feature/home/presentation/widgets/category_card.dart';
import 'package:spex/feature/home/presentation/widgets/my_appbar.dart';
import 'package:spex/feature/home/presentation/widgets/product_card.dart';
import 'package:spex/feature/home/presentation/widgets/promo_banner.dart';
import 'package:spex/feature/home/presentation/widgets/section_header.dart';
import 'package:spex/feature/home/view_model/category_cubit/category_cubit.dart';
import 'package:spex/feature/home/view_model/category_cubit/category_state.dart';
import 'package:spex/feature/layout/view_model/layout_cubit/layout_cubit.dart';
import 'package:spex/generated/locale_keys.g.dart';
import 'package:spex/main.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    bool isMobile = size.width <= ValuesOfAllApp.mobileWidth;
    return Scaffold(
      // drawer: const MyDrawer(),
      body: CustomScrollView(
        slivers: [
          MyHomeAppBar(),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SvgPicture.asset(
                  "assets/images/final-mob.svg",
                  height: 60,
                  width: double.infinity,
                  fit: BoxFit.fill,
                ),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PromoBanner(items: HomeMockData.banners),
                  SizedBox(height: 24),
                  SectionHeader(
                    title: LocaleKeys.home_categories.tr(),
                    actionText: LocaleKeys.home_view_all.tr(),
                    onActionPressed: () {
                      context.read<LayoutCubit>().changeIndex(1);
                    },
                  ),
                  SizedBox(height: 12),
                  SizedBox(
                    height: isMobile ? 140 : 190,
                    child: BlocBuilder<CategoryCubit, CategoryState>(
                      builder: (context, state) {
                        if (state is CategoryLoadingState) {
                          return const Center(
                            child: CircularProgressIndicator(
                              color: AppColorsLight.mainColor,
                            ),
                          );
                        } else if (state is CategoryLoadedState) {
                          return ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: state.categories.length,
                            separatorBuilder: (context, index) =>
                                SizedBox(width: 16),
                            itemBuilder: (context, index) {
                              return CategoryCard(
                                category: state.categories[index],
                              );
                            },
                          );
                        } else if (state is CategoryErrorState) {
                          return Center(child: TextInAppWidget(text: state.errorMessage.tr(), textColor: isDark ? AppColorsDark.appTextColor : AppColorsLight.appTextColor));
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                  ),
                  SizedBox(height: 24),
                  SectionHeader(
                    title: LocaleKeys.home_best_offers.tr(),
                    actionText: LocaleKeys.home_more.tr(),
                    onActionPressed: () {},
                  ),
                  SizedBox(height: 12),
                  SizedBox(
                    height: context.screenWidth * 0.7,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return SizedBox(
                          width: 180,
                          child: InkWell(
                            child: ProductCard(
                              product: HomeMockData.bestOffers[index],
                            ),
                            onTap: () {
                              context.pushNamed(
                                Routes.productDetailsScreen,
                                arguments: HomeMockData.bestOffers[index],
                              );
                            },
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(width: 12);
                      },
                      itemCount: HomeMockData.bestOffers.length,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
