import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:spex/core/helpers/colors/dark_colors.dart';
import 'package:spex/core/helpers/colors/light_colors.dart';
import 'package:spex/core/helpers/constants/constants.dart';
import 'package:spex/core/widgets/text_in_app_widget.dart';
import 'package:spex/feature/notification/data/model/notification_model.dart';
import 'package:spex/main.dart';

class NotificationItem extends StatelessWidget {
  final NotificationModel notification;
  final VoidCallback? onTap;

  const NotificationItem({super.key, required this.notification, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isDark
              ? AppColorsDark.appSecondBgColor
              : AppColorsLight.whiteColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 48,
              width: 48,
              decoration: BoxDecoration(
                color: isDark
                    ? AppColorsDark.appBgColor
                    : AppColorsLight.appBgColor,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.notifications_outlined,
                color: AppColorsLight.mainColor,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: TextInAppWidget(
                          text: notification.title,
                          textSize: 14,
                          fontWeightIndex: FontSelectionData.semiBoldFontFamily,
                          textColor: isDark
                              ? Colors.white
                              : AppColorsLight.darkColor,
                          isEllipsisTextOverflow: true,
                        ),
                      ),
                      TextInAppWidget(
                        text: DateFormat(
                          'MMM d, h:mm a',
                        ).format(notification.time),
                        textSize: 10,
                        textColor: isDark
                            ? AppColorsDark.appSecondTextColor
                            : AppColorsLight.appSecondTextColor,
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  TextInAppWidget(
                    text: notification.body,
                    textSize: 12,
                    maxLines: 2,
                    isEllipsisTextOverflow: true,
                    textColor: isDark
                        ? AppColorsDark.appSecondTextColor
                        : AppColorsLight.appSecondTextColor,
                  ),
                ],
              ),
            ),
            if (!notification.isRead) ...[
              const SizedBox(width: 8),
              Container(
                width: 8,
                height: 8,
                margin: const EdgeInsets.only(top: 6),
                decoration: const BoxDecoration(
                  color: AppColorsLight.mainColor,
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
