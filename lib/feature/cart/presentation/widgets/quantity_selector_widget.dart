import 'package:flutter/material.dart';
import '../../../../core/helpers/colors/dark_colors.dart';
import '../../../../core/helpers/colors/light_colors.dart';
import '../../../../core/helpers/constants/constants.dart';
import '../../../../core/widgets/text_in_app_widget.dart';
import '../../../../main.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'quantity_action_button_widget.dart';

class QuantitySelectorWidget extends StatelessWidget {
  final int quantity;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const QuantitySelectorWidget({
    super.key,
    required this.quantity,
    required this.onIncrement,
    required this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppColorsDark.appBgColor : AppColorsLight.appBgColor,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          QuantityActionButtonWidget(icon: Icons.remove, onTap: onDecrement),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: TextInAppWidget(
              text: quantity.toString(),
              textSize: 14,
              fontWeightIndex: FontSelectionData.semiBoldFontFamily,
              textColor: isDark
                  ? AppColorsDark.appTextColor
                  : AppColorsLight.appTextColor,
            ),
          ),
          QuantityActionButtonWidget(icon: Icons.add, onTap: onIncrement),
        ],
      ),
    );
  }
}
