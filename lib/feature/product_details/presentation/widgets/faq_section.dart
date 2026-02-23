import 'package:flutter/material.dart';
import '../../../../core/helpers/colors/dark_colors.dart';
import '../../../../core/helpers/colors/light_colors.dart';
import '../../../../core/widgets/text_in_app_widget.dart';
import '../../../../core/helpers/constants/constants.dart';
import '../../../../main.dart';
import 'package:spex/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'faq_item.dart';

class FAQSection extends StatelessWidget {
  const FAQSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextInAppWidget(
          text: LocaleKeys.delivery_return_faqs_header.tr(),
          textSize: 18,
          fontWeightIndex: FontSelectionData.boldFontFamily,
          textColor: isDark
              ? AppColorsDark.mainColor
              : AppColorsLight.mainColor,
        ),
        const SizedBox(height: 12),
        FAQItem(
          question: LocaleKeys.delivery_return_faq_q1.tr(),
          answer: LocaleKeys.delivery_return_faq_a1.tr(),
        ),
        FAQItem(
          question: LocaleKeys.delivery_return_faq_q2.tr(),
          answer: LocaleKeys.delivery_return_faq_a2.tr(),
        ),
        FAQItem(
          question: LocaleKeys.delivery_return_faq_q3.tr(),
          answer: LocaleKeys.delivery_return_faq_a3.tr(),
        ),
      ],
    );
  }
}
