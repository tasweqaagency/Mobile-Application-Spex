import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:spex/generated/locale_keys.g.dart';
import '../../../../core/helpers/colors/dark_colors.dart';
import '../../../../core/helpers/colors/light_colors.dart';
import '../../../../core/helpers/constants/constants.dart';
import '../../../../core/widgets/text_in_app_widget.dart';
import '../../../../main.dart';

class ProductColorWidget extends StatefulWidget {
  final List<Color> colors;
  final Function(Color) onColorSelected;

  const ProductColorWidget({
    super.key,
    required this.colors,
    required this.onColorSelected,
  });

  @override
  State<ProductColorWidget> createState() => _ProductColorWidgetState();
}

class _ProductColorWidgetState extends State<ProductColorWidget> {
  Color? selectedColor;

  @override
  Widget build(BuildContext context) {
    if (widget.colors.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextInAppWidget(
          text: LocaleKeys.product_details_select_color.tr(),
          textSize: 16,
          fontWeightIndex: FontSelectionData.boldFontFamily,
          textColor: isDark
              ? AppColorsDark.appTextColor
              : AppColorsLight.appTextColor,
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 15,
          runSpacing: 15,
          children: widget.colors.map((color) {
            final isSelected = selectedColor == color;
            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedColor = color;
                });
                widget.onColorSelected(color);
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: 35,
                height: 35,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
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
                    width: isSelected ? 3 : 1,
                  ),
                  boxShadow: [
                    if (isSelected)
                      BoxShadow(
                        color:
                            (isDark
                                    ? AppColorsDark.mainColor
                                    : AppColorsLight.mainColor)
                                .withValues(alpha: 0.5),
                        blurRadius: 10,
                        spreadRadius: 2,
                      )
                    else
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                  ],
                ),
                child: isSelected
                    ? Icon(
                        Icons.check,
                        size: 20,
                        color: _getContrastColor(color),
                      )
                    : null,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Color _getContrastColor(Color color) {
    return color.computeLuminance() > 0.5 ? Colors.black : Colors.white;
  }
}
