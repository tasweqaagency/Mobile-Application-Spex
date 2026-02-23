import 'package:flutter/material.dart';
import 'package:spex/core/helpers/constants/constants.dart';
import 'package:spex/feature/home/model/home_mock_data.dart';
import 'package:spex/feature/home/presentation/widgets/category_card.dart';
import 'package:spex/feature/home/presentation/widgets/my_appbar.dart';

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
        child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
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
          itemCount: HomeMockData.categories.length,
          itemBuilder: (context, index) {
            return CategoryCard(
              category: HomeMockData.categories[index],
              isLargeCategory: true,
            );
          },
        ),
      ),
    );
  }
}
