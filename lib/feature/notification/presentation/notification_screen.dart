import 'package:flutter/material.dart';
import 'package:spex/core/helpers/colors/dark_colors.dart';
import 'package:spex/core/helpers/colors/light_colors.dart';
import 'package:spex/feature/home/presentation/widgets/my_appbar.dart';
import 'package:spex/feature/notification/data/model/notification_model.dart';
import 'package:spex/feature/notification/presentation/widgets/notification_item.dart';
import 'package:spex/main.dart';

import 'package:spex/core/widgets/text_in_app_widget.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  // Dummy data
  final List<NotificationModel> notifications = [
    NotificationModel(
      id: 1,
      title: 'Order Shipped',
      body: 'Your order #12345 has been shipped and is on its way!',
      time: DateTime.now().subtract(const Duration(minutes: 5)),
      isRead: false,
    ),
    NotificationModel(
      id: 2,
      title: 'New Offer!',
      body: 'Get 20% off on your next purchase. Use code SPEX20.',
      time: DateTime.now().subtract(const Duration(hours: 2)),
      isRead: true,
    ),
    NotificationModel(
      id: 3,
      title: 'Account Update',
      body: 'Your profile information has been successfully updated.',
      time: DateTime.now().subtract(const Duration(days: 1)),
      isRead: true,
    ),
    NotificationModel(
      id: 4,
      title: 'Flash Sale',
      body: 'Don\'t miss out on our flash sale starting tomorrow!',
      time: DateTime.now().subtract(const Duration(days: 2)),
      isRead: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isDark
          ? AppColorsDark.appBgColor
          : AppColorsLight.appBgColor,
      appBar: const MyAppBarWithBackButton(
        title: "Notification",
        showSearch: false,
      ),
      body: notifications.isEmpty
          ? Center(
              child: TextInAppWidget(
                text: "No notifications yet",
                textSize: 16,
                textColor: isDark ? Colors.white : AppColorsLight.darkColor,
              ),
            )
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: notifications.length,
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                return NotificationItem(
                  notification: notifications[index],
                  onTap: () {
                    // Mark as read logic here
                  },
                );
              },
            ),
    );
  }
}
