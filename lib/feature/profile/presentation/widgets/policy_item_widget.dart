import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spex/core/helpers/constants/constants.dart';
import 'package:spex/core/widgets/text_in_app_widget.dart';
import 'package:spex/main.dart';

class PolicyItemWidget extends StatelessWidget {
  final String title;
  final String body;

  const PolicyItemWidget({super.key, required this.title, required this.body});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextInAppWidget(
          text: title,
          textSize: 18,
          fontWeightIndex: FontSelectionData.boldFontFamily,
          textColor: isDark ? Colors.white : Colors.black,
        ),
        verticalSpace(8),
        TextInAppWidget(
          text: body,
          textSize: 14,
          textColor: isDark ? Colors.white70 : Colors.black87,
          //height: 1.5,
        ),
        verticalSpace(24),
      ],
    );
  }

  SizedBox verticalSpace(double height) => SizedBox(height: height.h);
}
