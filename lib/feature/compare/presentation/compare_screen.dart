import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spex/core/helpers/colors/dark_colors.dart';
import 'package:spex/core/helpers/colors/light_colors.dart';
import 'package:spex/core/helpers/constants/constants.dart';
import 'package:spex/core/helpers/extentions/extentions.dart';
import 'package:spex/core/widgets/text_in_app_widget.dart';
import 'package:spex/feature/home/presentation/widgets/my_appbar.dart';
import 'package:spex/generated/locale_keys.g.dart';
import 'package:spex/core/helpers/themes/theme_cubit.dart';
import 'package:spex/main.dart';
import '../view_model/compare_cubit.dart';
import '../view_model/compare_state.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CompareScreen extends StatelessWidget {
  const CompareScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CompareCubit, CompareState>(
      builder: (context, state) {
        return BlocBuilder<ThemeCubit, ThemeMode>(
          builder: (context, mode) {
            // final isDarkLocal = mode == ThemeMode.dark;
            return Scaffold(
              backgroundColor: isDark
                  ? AppColorsDark.appBgColor
                  : AppColorsLight.appBgColor,
              appBar: MyAppBarWithBackButton(
                title: LocaleKeys.home_compare.tr(),
              ),
              body: _buildBody(context, state),
            );
          },
        );
      },
    );
  }

  Widget _buildBody(
    BuildContext context,
    CompareState state,
  ) {
    if (state is CompareLoading) {
      return Center(child: CircularProgressIndicator(color: AppColorsLight.mainColor));
    }
    if (state is CompareError) {
      return Center(child: TextInAppWidget(text: state.message, textColor: AppColorsLight.mainColor));
    }
    if (state is CompareLoaded) {
      if (state.products.isEmpty) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.compare_arrows,
                size: 64,
                color: AppColorsLight.mainColor,
              ),
              verticalSpace(16),
              TextInAppWidget(
                text: LocaleKeys.home_no_compare_found.tr(),
                textSize: 16,
                textColor: isDark?AppColorsDark.appTextColor:AppColorsLight.appTextColor,
              ),
            ],
          ),
        );
      }

      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SingleChildScrollView(
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildLabelsColumn(context, state),
                ...state.products.map(
                  (product) =>
                      _buildProductColumn(context, product),
                ),
              ],
            ),
          ),
        ),
      );
    }
    return const SizedBox();
  }

  Widget _buildLabelsColumn(
    BuildContext context,
    CompareLoaded state,
  ) {
    final attributes = _getAllUniqueAttributes(state);
    return Container(
      width: 130.w,
      decoration: BoxDecoration(
        color: isDark
            ? AppColorsDark.appSecondBgColor
            : AppColorsLight.whiteColor,
        border: Border(
          right: BorderSide(
            color: isDark ? Colors.grey[800]! : Colors.grey[200]!,
          ),
        ),
      ),
      child: Column(
        children: [
          _buildHeaderRow("", isLabel: true),
          _buildLabelRow(
            LocaleKeys.home_products.tr(),
            height: 180.h,
          ),
          _buildLabelRow(LocaleKeys.home_category.tr()),
          _buildLabelRow(LocaleKeys.auth_name.tr()),
          _buildLabelRow(LocaleKeys.cart_total.tr()),
          _buildLabelRow(LocaleKeys.product_details_reviews.tr()),
          ...attributes.map((attr) => _buildLabelRow(attr)),
          _buildActionRow(""),
        ],
      ),
    );
  }

  Widget _buildProductColumn(
    BuildContext context,
    dynamic product,
  ) {
    // Note: 'product' is SimplifiedProductModel
    final state = context.read<CompareCubit>().state as CompareLoaded;
    final attributes = _getAllUniqueAttributes(state);

    return Container(
      width: 150.w,
      decoration: BoxDecoration(
        color: isDark
            ? AppColorsDark.appBgColor
            : AppColorsLight.whiteColor,
        border: Border(
          right: BorderSide(
            color: isDark ? Colors.grey[800]! : Colors.grey[100]!,
          ),
        ),
      ),
      child: Column(
        children: [
          _buildHeaderRow(
            product.name,
            onRemove: () {
              context.read<CompareCubit>().toggleCompare(product);
            },
          ),
          _buildProductInfoRow(product),
          _buildValueRow(product.category),
          _buildValueRow(product.brand),
          _buildPriceRow(product),
          _buildRatingRow(product),
          ...attributes.map(
            (attr) => _buildAttributeValueRow(product, attr),
          ),
          _buildAddToCartAction(product),
        ],
      ),
    );
  }

  Widget _buildHeaderRow(
    String name, {
    VoidCallback? onRemove,
    bool isLabel = false,
  }) {
    return Container(
      height: 50.h,
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      alignment: Alignment.center,
      child: isLabel
          ? const SizedBox()
          : Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  onPressed: onRemove,
                  icon: Icon(
                    Icons.close,
                    size: 18,
                    color: isDark ? Colors.white70 : Colors.black54,
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildLabelRow(String label, {double? height}) {
    return Container(
      height: height ?? 60.h,
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      alignment: AlignmentDirectional.centerStart,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: isDark ? Colors.grey[800]! : Colors.grey[200]!,
          ),
        ),
      ),
      child: TextInAppWidget(
        text: label,
        textSize: 14,
        fontWeightIndex: FontSelectionData.boldFontFamily,
        maxLines: 2,
        isEllipsisTextOverflow: true,
        textColor: isDark ? Colors.white : Colors.black,
      ),
    );
  }

  Widget _buildProductInfoRow(dynamic product) {
    return Container(
      height: 180.h,
      padding: EdgeInsets.all(8.w),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: isDark ? Colors.grey[800]! : Colors.grey[200]!,
          ),
        ),
      ),
      child: Column(
        children: [
          Expanded(
            child: CachedNetworkImage(
              imageUrl: product.image,
              fit: BoxFit.contain,
              placeholder: (context, url) =>
                  const Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
          verticalSpace(8),
          TextInAppWidget(
            text: product.name,
            textSize: 12,
            maxLines: 2,
            textAlign: TextAlign.center,
            textColor: isDark ? Colors.white70 : Colors.black87,
          ),
        ],
      ),
    );
  }

  Widget _buildValueRow(String value) {
    return Container(
      height: 60.h,
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: isDark ? Colors.grey[800]! : Colors.grey[200]!,
          ),
        ),
      ),
      child: TextInAppWidget(
        text: value,
        textSize: 13,
        textAlign: TextAlign.center,
        maxLines: 2,
        isEllipsisTextOverflow: true,
        textColor: isDark ? Colors.white70 : Colors.black87,
      ),
    );
  }

  Widget _buildPriceRow(dynamic product) {
    return Container(
      height: 60.h,
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: isDark ? Colors.grey[800]! : Colors.grey[200]!,
          ),
        ),
      ),
      child: TextInAppWidget(
        text: "${product.price} ${LocaleKeys.home_egp.tr()}",
        textSize: 14,
        textColor: AppColorsLight.mainColor,
        fontWeightIndex: FontSelectionData.boldFontFamily,
      ),
    );
  }

  Widget _buildRatingRow(dynamic product) {
    return Container(
      height: 60.h,
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: isDark ? Colors.grey[800]! : Colors.grey[200]!,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.star, color: Colors.amber, size: 16),
          horizontalSpace(4),
          TextInAppWidget(
            text: product.rating.toString(),
            textSize: 14,
            textColor: isDark ? Colors.white : Colors.black,
          ),
        ],
      ),
    );
  }

  Widget _buildAttributeValueRow(
    dynamic product,
    String attrName,
  ) {
    final value =
        product.attributes
            .firstWhere((a) => a.name == attrName, orElse: () => null)
            ?.options
            .join(', ') ??
        '-';

    return Container(
      height: 60.h,
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: isDark ? Colors.grey[800]! : Colors.grey[200]!,
          ),
        ),
      ),
      child: TextInAppWidget(
        text: value,
        textSize: 13,
        textAlign: TextAlign.center,
        maxLines: 2,
        isEllipsisTextOverflow: true,
        textColor: isDark ? Colors.white70 : Colors.black87,
      ),
    );
  }

  Widget _buildActionRow(String s) {
    return Container(height: 80.h, alignment: Alignment.center);
  }

  Widget _buildAddToCartAction(dynamic product) {
    return Container(
      height: 80.h,
      padding: EdgeInsets.all(12.w),
      alignment: Alignment.center,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColorsLight.mainColor,
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          elevation: 0,
        ),
        child: TextInAppWidget(
          text: LocaleKeys.product_details_add_to_cart.tr(),
          textSize: 12,
          textColor: Colors.white,
          maxLines: 1,
          fontWeightIndex: FontSelectionData.boldFontFamily,
        ),
      ),
    );
  }

  List<String> _getAllUniqueAttributes(CompareLoaded state) {
    final Set<String> attributes = {};
    for (var product in state.products) {
      for (var attr in product.attributes) {
        attributes.add(attr.name);
      }
    }
    return attributes.toList();
  }
}
