import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:spex/core/helpers/colors/dark_colors.dart';
import 'package:spex/core/helpers/colors/light_colors.dart';
import 'package:spex/core/helpers/extentions/extentions.dart';
import 'package:spex/core/routing/routing.dart';
import 'package:spex/generated/locale_keys.g.dart';
import 'package:spex/core/helpers/constants/constants.dart';
import 'package:spex/feature/category/model/category_model.dart';
import 'package:spex/core/widgets/network_image_widget.dart';
import 'package:spex/core/widgets/text_in_app_widget.dart';
import 'package:spex/main.dart';

class CategoryCard extends StatelessWidget {
  final CategoryModel category;
  final bool isLargeCategory;

  const CategoryCard({
    super.key,
    required this.category,
    this.isLargeCategory = false,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    bool isMobile = size.width <= ValuesOfAllApp.mobileWidth;
    return GestureDetector(
      onTap: () {
        context.pushNamed(Routes.categoryProductsScreen, arguments: category);
      },
      child: Container(
        height: isLargeCategory
            ? (isMobile ? 130 : 150)
            : (isMobile ? 100 : 150),
        width: isLargeCategory
            ? (isMobile ? 130 : 150)
            : (isMobile ? 100 : 150),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isDark
              ? AppColorsDark.appSecondBgColor
              : AppColorsLight.whiteColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: NetworkImageWidget(
                imageUrl: category.imagePath,
                fit: BoxFit.fill,
                height: isLargeCategory
                    ? (isMobile ? 90 : 130)
                    : (isMobile ? 70 : 100),
                width: isLargeCategory
                    ? (isMobile ? 90 : 130)
                    : (isMobile ? 70 : 100),
              ),
            ),
            const SizedBox(height: 10),
            Flexible(
              child: TextInAppWidget(
                text: category.name,
                textSize: 14,
                fontWeightIndex: FontSelectionData.semiBoldFontFamily,
                textColor: isDark
                    ? AppColorsDark.appTextColor
                    : AppColorsLight.appTextColor,
                isEllipsisTextOverflow: true,
              ),
            ),
            // const SizedBox(height: 4),
            // Flexible(
            //   child: TextInAppWidget(
            //     text:
            //         '${category.productCount} ${LocaleKeys.home_products.tr()}',
            //     textSize: 11,
            //     textColor: isDark
            //         ? AppColorsDark.appSecondTextColor
            //         : AppColorsLight.appSecondTextColor,
            //     isEllipsisTextOverflow: true,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
