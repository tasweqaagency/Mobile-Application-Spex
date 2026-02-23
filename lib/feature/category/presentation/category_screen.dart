import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:spex/core/helpers/colors/light_colors.dart';
import 'package:spex/core/helpers/constants/constants.dart';
import 'package:spex/feature/home/presentation/widgets/category_card.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spex/feature/home/presentation/widgets/my_appbar.dart';
import 'package:spex/feature/home/view_model/category_cubit/category_cubit.dart';
import 'package:spex/feature/home/view_model/category_cubit/category_state.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    bool isMobile = size.width <= ValuesOfAllApp.mobileWidth;
    bool isTab = size.width <= ValuesOfAllApp.tabWidth;
    return Scaffold(
      appBar: MyAppBarWithLogo(),
      // drawer: const MyDrawer(),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: BlocBuilder<CategoryCubit, CategoryState>(
          builder: (context, state) {
            if (state is CategoryLoadingState) {
              return  Center(child: CircularProgressIndicator(color: AppColorsLight.mainColor,));
            } else if (state is CategoryLoadedState) {
              return GridView.builder(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: isMobile ? 2 : 3,
                  childAspectRatio: isMobile
                      ? 1
                      : isTab
                      ? 1.5
                      : 1.8,
                  crossAxisSpacing: isMobile
                      ? 16
                      : isTab
                      ? 18
                      : 20,
                  mainAxisSpacing: isMobile
                      ? 16
                      : isTab
                      ? 18
                      : 20,
                ),
                itemCount: state.categories.length,
                itemBuilder: (context, index) {
                  return CategoryCard(
                    category: state.categories[index],
                    isLargeCategory: true,
                  );
                },
              );
            } else if (state is CategoryErrorState) {
              return Center(child: Text(state.errorMessage.tr()));
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
