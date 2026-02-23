import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:spex/core/helpers/colors/dark_colors.dart';
import 'package:spex/core/helpers/colors/light_colors.dart';
import 'package:spex/core/helpers/constants/constants.dart';
import 'package:spex/core/helpers/fontSelection/font_selection.dart';
import 'package:spex/generated/locale_keys.g.dart';
import 'package:spex/main.dart';

import 'package:spex/feature/product_details/presentation/widgets/description_tab.dart';

class ProductDetailsTapBar extends StatefulWidget {
  const ProductDetailsTapBar({super.key});

  @override
  State<ProductDetailsTapBar> createState() => _ProductDetailsTapBarState();
}

class _ProductDetailsTapBarState extends State<ProductDetailsTapBar>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        TabBar(
          controller: _tabController,
          isScrollable: true,
          padding: EdgeInsets.zero,
          indicatorPadding: EdgeInsets.zero,
          labelPadding: const EdgeInsets.symmetric(horizontal: 16),
          tabAlignment: TabAlignment.start,
          labelColor: isDark
              ? AppColorsDark.appTextColor
              : AppColorsLight.appTextColor,
          unselectedLabelColor: isDark
              ? AppColorsDark.appSecondTextColor
              : AppColorsLight.appSecondTextColor,
          indicatorColor: AppColorsLight.mainColor,
          indicatorSize: TabBarIndicatorSize.tab,
          dividerColor: Colors.transparent,
          labelStyle: TextStyle(
            fontSize: 16,
            fontWeight: fontWeightSelection(
              fontWeightIndex: FontSelectionData.boldFontFamily,
            ),
            fontFamily: fontSelection(),
          ),
          unselectedLabelStyle: TextStyle(
            fontSize: 16,
            fontWeight: fontWeightSelection(
              fontWeightIndex: FontSelectionData.regularFontFamily,
            ),
            fontFamily: fontSelection(),
          ),
          tabs: [
            Tab(text: LocaleKeys.product_details_description.tr()),
            Tab(text: LocaleKeys.product_details_specifications.tr()),
          ],
        ),
        const SizedBox(height: 20),
        SizedBox(
          height: 300, // Increased height slightly to accommodate content
          child: TabBarView(
            controller: _tabController,
            children: [
              const DescriptionTab(),
              const Center(child: Text("Specification Content")),
              // const Center(child: Text("Delivery Content")),
            ],
          ),
        ),
      ],
    );
  }
}
