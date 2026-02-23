import 'package:flutter/material.dart';
import '../../../../core/helpers/colors/dark_colors.dart';
import '../../../../core/helpers/colors/light_colors.dart';
import '../../../../core/widgets/text_in_app_widget.dart';
import '../../../../core/helpers/constants/constants.dart';
import '../../../../main.dart';
import 'package:spex/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'help_item.dart';
import 'social_icon.dart';

class NeedHelpSection extends StatelessWidget {
  const NeedHelpSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColorsLight.mainColor.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColorsLight.mainColor.withValues(alpha: 0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextInAppWidget(
            text: LocaleKeys.delivery_return_need_help.tr(),
            textSize: 16,
            fontWeightIndex: FontSelectionData.boldFontFamily,
            textColor: isDark
                ? AppColorsDark.mainColor
                : AppColorsLight.mainColor,
          ),
          const SizedBox(height: 12),
          const HelpItem(icon: Icons.phone_outlined, text: "+201275555063"),
          const SizedBox(height: 8),
          const HelpItem(icon: Icons.email_outlined, text: "online@spexeg.com"),
          const SizedBox(height: 16),
          TextInAppWidget(
            text: LocaleKeys.delivery_return_subscribe_us.tr(),
            textSize: 14,
            fontWeightIndex: FontSelectionData.semiBoldFontFamily,
            textColor: isDark
                ? AppColorsDark.appTextColor
                : AppColorsLight.appTextColor,
          ),
          const SizedBox(height: 8),
          Row(
            children: const [
              SocialIcon(icon: Icons.facebook),
              SizedBox(width: 12),
              SocialIcon(icon: Icons.camera_alt_outlined),
            ],
          ),
        ],
      ),
    );
  }
}
