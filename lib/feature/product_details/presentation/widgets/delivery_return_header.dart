import 'package:flutter/material.dart';
import '../../../../core/helpers/colors/dark_colors.dart';
import '../../../../core/helpers/colors/light_colors.dart';
import '../../../../core/widgets/text_in_app_widget.dart';
import '../../../../core/helpers/constants/constants.dart';
import '../../../../main.dart';
import 'package:spex/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

class DeliveryReturnHeader extends StatelessWidget {
  const DeliveryReturnHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColorsLight.mainColor.withValues(alpha: 0.1),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.delivery_dining_outlined,
            color: isDark ? AppColorsDark.mainColor : AppColorsLight.mainColor,
            size: 28,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: TextInAppWidget(
              text: LocaleKeys.delivery_return_title.tr(),
              textSize: 20,
              fontWeightIndex: FontSelectionData.boldFontFamily,
              textColor: isDark
                  ? AppColorsDark.mainColor
                  : AppColorsLight.mainColor,
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.close,
              color: isDark
                  ? AppColorsDark.mainColor
                  : AppColorsLight.mainColor,
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}
