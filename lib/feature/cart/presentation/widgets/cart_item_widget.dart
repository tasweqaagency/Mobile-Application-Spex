import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spex/core/helpers/colors/dark_colors.dart';
import 'package:spex/core/helpers/colors/light_colors.dart';
import 'package:spex/core/helpers/constants/constants.dart';
import 'package:spex/core/helpers/extentions/extentions.dart';
import 'package:spex/core/widgets/network_image_widget.dart';
import 'package:spex/core/widgets/text_in_app_widget.dart';
import 'package:spex/feature/cart/view_model/cart_cubit.dart';
import 'package:spex/main.dart';
import 'package:spex/feature/cart/presentation/widgets/quantity_selector_widget.dart';
import 'package:spex/generated/locale_keys.g.dart';
import 'package:spex/feature/cart/model/cart_item.dart';

class CartItemWidget extends StatelessWidget {
  final CartItem item;

  const CartItemWidget({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.all(10),
      decoration: myBoxDecoration(),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          NetworkImageWidget(
            imageUrl: item.image,
            width: 80.w,
            height: 80.w,
            borderRadius: BorderRadius.circular(18.r),
          ),
          SizedBox(width: 12),
          // Product Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: TextInAppWidget(
                        text: item.name,
                        textColor: isDark
                            ? AppColorsDark.appTextColor
                            : AppColorsLight.appTextColor,
                        textSize: 14,
                        fontWeightIndex: FontSelectionData.semiBoldFontFamily,
                        isEllipsisTextOverflow: true,
                        maxLines: 1,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        context.read<CartCubit>().removeFromCart(
                          item.productId,
                          variationId: item.variationId,
                          selectedSize: item.selectedSize,
                          selectedColor: item.selectedColor,
                        );
                      },
                      icon: Icon(
                        Icons.close,
                        size: 20.sp,
                        color: isDark
                            ? AppColorsDark.appSecondTextColor
                            : AppColorsLight.appSecondTextColor,
                      ),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      visualDensity: VisualDensity.compact,
                    ),
                  ],
                ),
                if ((item.selectedSize != null && item.selectedSize!.isNotEmpty) ||
                    (item.selectedColor != null && item.selectedColor!.isNotEmpty))
                  Padding(
                    padding: const EdgeInsets.only(top: 6.0),
                    child: Wrap(
                      spacing: 8,
                      runSpacing: 6,
                      children: [
                        if (item.selectedSize != null &&
                            item.selectedSize!.isNotEmpty)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: isDark
                                  ? AppColorsDark.appSecondBgColor
                                  : AppColorsLight.appSecondBgColor,
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: TextInAppWidget(
                              text:
                                  "${LocaleKeys.product_details_size.tr()}: ${item.selectedSize}",
                              textSize: 11,
                              textColor: isDark
                                  ? AppColorsDark.appSecondTextColor
                                  : AppColorsLight.appSecondTextColor,
                            ),
                          ),
                        if (item.selectedColor != null &&
                            item.selectedColor!.isNotEmpty)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: isDark
                                  ? AppColorsDark.appSecondBgColor
                                  : AppColorsLight.appSecondBgColor,
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TextInAppWidget(
                                  text:
                                      "${LocaleKeys.product_details_color.tr()}: ${item.selectedColor}",
                                  textSize: 11,
                                  textColor: isDark
                                      ? AppColorsDark.appSecondTextColor
                                      : AppColorsLight.appSecondTextColor,
                                ),
                                const SizedBox(width: 6),
                                Container(
                                  width: 11.w,
                                  height: 11.w,
                                  decoration: BoxDecoration(
                                    color: (item.variation?.attributes?.paColor
                                                    ?.hex !=
                                                null &&
                                            item.variation!.attributes!.paColor!
                                                .hex!.isNotEmpty)
                                        ? item.variation!.attributes!.paColor!
                                            .hex!.toColor()
                                        : item.selectedColor!.toColor(),
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: isDark
                                          ? Colors.white24
                                          : Colors.black12,
                                      width: 0.5,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextInAppWidget(
                      text: "${item.price} ${LocaleKeys.home_egp.tr()}",
                      textSize: 16,
                      fontWeightIndex: FontSelectionData.boldFontFamily,
                      textColor: AppColorsLight.mainColor,
                    ),
                    QuantitySelectorWidget(
                      quantity: item.quantity,
                      onIncrement: () {
                        context.read<CartCubit>().incrementQuantity(
                              item.productId,
                              variationId: item.variationId,
                              selectedSize: item.selectedSize,
                              selectedColor: item.selectedColor,
                            );
                      },
                      onDecrement: () {
                        context.read<CartCubit>().decrementQuantity(
                              item.productId,
                              variationId: item.variationId,
                              selectedSize: item.selectedSize,
                              selectedColor: item.selectedColor,
                            );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
