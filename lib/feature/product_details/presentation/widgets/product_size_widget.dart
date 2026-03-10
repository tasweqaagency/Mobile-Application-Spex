import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:spex/generated/locale_keys.g.dart';
import '../../../../core/helpers/colors/dark_colors.dart';
import '../../../../core/helpers/colors/light_colors.dart';
import '../../../../core/helpers/constants/constants.dart';
import '../../../../core/widgets/text_in_app_widget.dart';
import '../../../../main.dart';

class ProductSizeWidget extends StatefulWidget {
  final List<String> sizes;
  final Function(String) onSizeSelected;

  const ProductSizeWidget({
    super.key,
    required this.sizes,
    required this.onSizeSelected,
  });

  @override
  State<ProductSizeWidget> createState() => _ProductSizeWidgetState();
}

class _ProductSizeWidgetState extends State<ProductSizeWidget> {
  String? selectedSize;

  @override
  Widget build(BuildContext context) {
    if (widget.sizes.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextInAppWidget(
          text: LocaleKeys.product_details_select_size.tr(),
          textSize: 16,
          fontWeightIndex: FontSelectionData.boldFontFamily,
          textColor: isDark
              ? AppColorsDark.appTextColor
              : AppColorsLight.appTextColor,
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: widget.sizes.map((size) {
            final isSelected = selectedSize == size;
            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedSize = size;
                });
                widget.onSizeSelected(size);
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: isSelected
                      ? (isDark
                            ? AppColorsDark.mainColor
                            : AppColorsLight.mainColor)
                      : (isDark
                            ? AppColorsDark.appSecondBgColor
                            : AppColorsLight.whiteColor),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: isSelected
                        ? (isDark
                              ? AppColorsDark.mainColor
                              : AppColorsLight.mainColor)
                        : (isDark
                              ? AppColorsDark.appSecondTextColor.withValues(
                                  alpha: 0.3,
                                )
                              : AppColorsLight.appSecondTextColor.withValues(
                                  alpha: 0.3,
                                )),
                    width: 1.5,
                  ),
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color:
                                (isDark
                                        ? AppColorsDark.mainColor
                                        : AppColorsLight.mainColor)
                                    .withValues(alpha: 0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ]
                      : [],
                ),
                child: TextInAppWidget(
                  text: size,
                  textSize: 14,
                  fontWeightIndex: isSelected
                      ? FontSelectionData.boldFontFamily
                      : FontSelectionData.regularFontFamily,
                  textColor: isSelected
                      ? (isDark ? AppColorsDark.appTextColor : Colors.white)
                      : (isDark
                            ? AppColorsDark.appTextColor
                            : AppColorsLight.appTextColor),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
