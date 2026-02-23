import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../../core/helpers/colors/dark_colors.dart';
import '../../../../core/helpers/colors/light_colors.dart';
import '../../../../core/helpers/constants/constants.dart';
import '../../../../core/helpers/extentions/extentions.dart';
import '../../../../core/widgets/text_in_app_widget.dart';
import '../../../../main.dart';

class OrdersTimelineItem extends StatelessWidget {
  final String title;
  final DateTime date;
  final bool completed;
  final bool isLast;
  final bool isFirst;

  const OrdersTimelineItem({
    super.key,
    required this.title,
    required this.date,
    required this.completed,
    this.isLast = false,
    this.isFirst = false,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        children: [
          Column(
            children: [
              Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: completed
                      ? AppColorsLight.greenColor2
                      : (isDark ? Colors.grey[800] : Colors.grey[200]),
                ),
                child: completed
                    ? const Icon(Icons.check, color: Colors.white, size: 12)
                    : null,
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2,
                    color: completed
                        ? AppColorsLight.greenColor2
                        : (isDark ? Colors.grey[800] : Colors.grey[200]),
                  ),
                ),
            ],
          ),
          horizontalSpace(16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextInAppWidget(
                  text: title,
                  textSize: 14,
                  fontWeightIndex: FontSelectionData.boldFontFamily,
                  textColor: isDark
                      ? AppColorsDark.whiteColor
                      : AppColorsLight.appTextColor,
                ),
                TextInAppWidget(
                  text: DateFormat("MMM dd, yyyy • hh:mm a").format(date),
                  textSize: 11,
                  textColor: isDark
                      ? AppColorsDark.appSecondTextColor
                      : AppColorsLight.appSecondTextColor,
                ),
                if (!isLast) verticalSpace(20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
