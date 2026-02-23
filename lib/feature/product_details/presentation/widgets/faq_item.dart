import 'package:flutter/material.dart';
import '../../../../core/helpers/colors/dark_colors.dart';
import '../../../../core/helpers/colors/light_colors.dart';
import '../../../../core/widgets/text_in_app_widget.dart';
import '../../../../core/helpers/constants/constants.dart';
import '../../../../main.dart';
import 'info_text.dart';

class FAQItem extends StatelessWidget {
  final String question;
  final String answer;

  const FAQItem({super.key, required this.question, required this.answer});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        title: TextInAppWidget(
          text: question,
          textSize: 14,
          fontWeightIndex: FontSelectionData.semiBoldFontFamily,
          textColor: isDark
              ? AppColorsDark.mainColor
              : AppColorsLight.mainColor,
        ),
        iconColor: isDark ? AppColorsDark.mainColor : AppColorsLight.mainColor,
        collapsedIconColor: isDark
            ? AppColorsDark.mainColor.withValues(alpha: 0.5)
            : AppColorsLight.mainColor.withValues(alpha: 0.5),
        childrenPadding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
        children: [InfoText(text: answer)],
      ),
    );
  }
}
