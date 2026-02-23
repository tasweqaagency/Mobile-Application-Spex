import 'package:flutter/material.dart';
import '../../../../core/helpers/colors/dark_colors.dart';
import '../../../../core/helpers/colors/light_colors.dart';
import '../../../../core/widgets/text_in_app_widget.dart';
import '../../../../core/helpers/constants/constants.dart';
import '../../../../main.dart';
import 'package:spex/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'bullet_point.dart';

class ReturnSection extends StatelessWidget {
  const ReturnSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextInAppWidget(
          text: LocaleKeys.delivery_return_return_header.tr(),
          textSize: 18,
          fontWeightIndex: FontSelectionData.boldFontFamily,
          textColor: isDark
              ? AppColorsDark.mainColor
              : AppColorsLight.mainColor,
        ),
        const SizedBox(height: 12),
        BulletPoint(text: LocaleKeys.delivery_return_return_bullet_1.tr()),
        BulletPoint(text: LocaleKeys.delivery_return_return_bullet_2.tr()),
        BulletPoint(text: LocaleKeys.delivery_return_return_bullet_3.tr()),
        BulletPoint(text: LocaleKeys.delivery_return_return_bullet_4.tr()),
        BulletPoint(text: LocaleKeys.delivery_return_return_bullet_5.tr()),
        BulletPoint(text: LocaleKeys.delivery_return_return_bullet_6.tr()),
        BulletPoint(text: LocaleKeys.delivery_return_return_bullet_7.tr()),
        BulletPoint(text: LocaleKeys.delivery_return_return_bullet_8.tr()),
      ],
    );
  }
}
