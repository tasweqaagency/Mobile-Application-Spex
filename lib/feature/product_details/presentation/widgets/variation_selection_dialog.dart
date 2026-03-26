import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:spex/core/helpers/colors/dark_colors.dart';
import 'package:spex/core/helpers/colors/light_colors.dart';
import 'package:spex/core/helpers/constants/constants.dart';
import 'package:spex/core/helpers/extentions/extentions.dart';
import 'package:spex/core/widgets/text_in_app_widget.dart';
import 'package:spex/feature/home/model/product_model.dart';
import 'package:spex/feature/product_details/model/mini_product_model.dart';
import 'package:spex/generated/locale_keys.g.dart';
import 'package:spex/main.dart';
import 'product_color_widget.dart';
import 'product_size_widget.dart';

class VariationSelectionDialog extends StatefulWidget {
  final SimplifiedProductModel product;

  const VariationSelectionDialog({super.key, required this.product});

  @override
  State<VariationSelectionDialog> createState() =>
      _VariationSelectionDialogState();
}

class _VariationSelectionDialogState extends State<VariationSelectionDialog> {
  Color? selectedColor;
  String? selectedSize;
  Variations? matchedVariation;

  void _findMatchedVariation() {
    if (widget.product.variations == null) return;

    Variations? found;
    for (var v in widget.product.variations!) {
      bool colorMatch = true;
      bool sizeMatch = true;

      // Color matching (comparing hex)
      if (selectedColor != null) {
        String? hex = v.attributes?.paColor?.hex;
        if (hex != null) {
          colorMatch = hex.toColor() == selectedColor;
        } else {
          colorMatch = false;
        }
      }

      // Size matching (comparing label)
      if (selectedSize != null) {
        sizeMatch = v.attributes?.paSize?.label == selectedSize;
      }

      if (colorMatch && sizeMatch) {
        found = v;
        break;
      }
    }

    if (matchedVariation != found) {
      setState(() {
        matchedVariation = found;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: isDark ? AppColorsDark.appSecondBgColor : Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: TextInAppWidget(
        text: LocaleKeys.product_details_select_variation.tr(),
        textSize: 18,
        fontWeightIndex: FontSelectionData.boldFontFamily,
        textColor: isDark ? Colors.white : Colors.black,
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.product.colors.isNotEmpty) ...[
              ProductColorWidget(
                colors: widget.product.colors,
                selectedColor: selectedColor,
                onColorSelected: (color) {
                  setState(() {
                    selectedColor = color;
                  });
                  _findMatchedVariation();
                },
              ),
              const SizedBox(height: 20),
            ],
            if (widget.product.availableSizes.isNotEmpty) ...[
              ProductSizeWidget(
                sizes: widget.product.availableSizes,
                selectedSize: selectedSize,
                onSizeSelected: (size) {
                  setState(() {
                    selectedSize = size;
                  });
                  _findMatchedVariation();
                },
              ),
              const SizedBox(height: 20),
            ],

            // Dynamic Price & Stock Display
            if (matchedVariation != null ||
                (selectedColor != null || selectedSize != null)) ...[
              const Divider(),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextInAppWidget(
                    text: "${LocaleKeys.product_details_price.tr()}:",
                    textSize: 16,
                    fontWeightIndex: FontSelectionData.boldFontFamily,
                    textColor: isDark
                        ? AppColorsDark.appSecondTextColor
                        : AppColorsLight.appSecondTextColor,
                  ),
                  TextInAppWidget(
                    text:
                        "${matchedVariation?.price ?? widget.product.price} ${LocaleKeys.home_egp.tr()}",
                    textSize: 16,
                    fontWeightIndex: FontSelectionData.boldFontFamily,
                    textColor: isDark
                        ? AppColorsDark.mainColor
                        : AppColorsLight.mainColor,
                  ),
                ],
              ),
              const SizedBox(height: 8),
              if (matchedVariation != null)
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(
                      matchedVariation!.stockStatus == StockStatus.instock.name
                          ? Icons.check_circle_outline
                          : Icons.error_outline,
                      size: 16,
                      color:
                          matchedVariation!.stockStatus ==
                              StockStatus.instock.name
                          ? AppColorsLight.greenColor2
                          : AppColorsLight.appRedColor,
                    ),
                    const SizedBox(width: 4),
                    TextInAppWidget(
                      text:
                          matchedVariation!.stockStatus ==
                              StockStatus.instock.name
                          ? LocaleKeys.home_in_stock.tr()
                          : LocaleKeys.home_out_of_stock.tr(),
                      textSize: 14,
                      textColor:
                          matchedVariation!.stockStatus ==
                              StockStatus.instock.name
                          ? AppColorsLight.greenColor2
                          : AppColorsLight.appRedColor,
                    ),
                  ],
                ),
            ],
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: TextInAppWidget(
            text: LocaleKeys.cart_cancel.tr(),
            textSize: 16,
            fontWeightIndex: FontSelectionData.boldFontFamily,
            textColor: isDark
                ? AppColorsDark.mainColor
                : AppColorsLight.mainColor,
          ),
        ),
        ElevatedButton(
          onPressed:
              _isSelectionComplete() &&
                  (matchedVariation == null ||
                      matchedVariation!.stockStatus == StockStatus.instock.name)
              ? () => Navigator.pop(context, {
                  'variation': matchedVariation,
                  'color': selectedColor,
                  'size': selectedSize,
                })
              : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: isDark
                ? AppColorsDark.mainColor
                : AppColorsLight.mainColor,
            disabledBackgroundColor: isDark
                ? AppColorsDark.spexGrayColor
                : AppColorsLight.spexGrayColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: TextInAppWidget(
            text: LocaleKeys.product_details_add_to_cart.tr(),
            textSize: 16,
            fontWeightIndex: FontSelectionData.boldFontFamily,
            textColor: Colors.white,
          ),
        ),
      ],
    );
  }

  bool _isSelectionComplete() {
    bool colorNeeded = widget.product.colors.isNotEmpty;
    bool sizeNeeded = widget.product.availableSizes.isNotEmpty;
    bool variationsExist =
        widget.product.variations != null &&
        widget.product.variations!.isNotEmpty;

    bool colorSelected = selectedColor != null;
    bool sizeSelected = selectedSize != null;

    bool hasSelection = true;
    if (colorNeeded) hasSelection = hasSelection && colorSelected;
    if (sizeNeeded) hasSelection = hasSelection && sizeSelected;

    if (variationsExist) {
      return hasSelection && matchedVariation != null;
    }

    return hasSelection;
  }
}
