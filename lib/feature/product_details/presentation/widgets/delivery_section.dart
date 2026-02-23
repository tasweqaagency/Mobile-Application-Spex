import 'package:flutter/material.dart';
import '../../../../core/helpers/colors/dark_colors.dart';
import '../../../../core/helpers/colors/light_colors.dart';
import '../../../../core/widgets/text_in_app_widget.dart';
import '../../../../core/helpers/constants/constants.dart';
import '../../../../main.dart';
import 'package:spex/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'info_text.dart';

class DeliverySection extends StatelessWidget {
  const DeliverySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextInAppWidget(
          text: LocaleKeys.delivery_return_delivery_header.tr(),
          textSize: 18,
          fontWeightIndex: FontSelectionData.boldFontFamily,
          textColor: isDark
              ? AppColorsDark.mainColor
              : AppColorsLight.mainColor,
        ),
        const SizedBox(height: 12),
        InfoText(text: LocaleKeys.delivery_return_delivery_desc.tr()),
      ],
    );
  }
}
