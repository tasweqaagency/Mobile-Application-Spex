import 'package:flutter/material.dart';

import '../../../../core/helpers/colors/light_colors.dart';
import '../../../../core/widgets/text_in_app_widget.dart';
import '../../../../main.dart';

class NotificationIconButton extends StatelessWidget {
  const NotificationIconButton({super.key, this.count, this.onTap});
  final int? count;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      hoverColor: Colors.transparent,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(right: 8),
            child: Icon(
              Icons.notifications_none,
              color: isDark ? Colors.white : AppColorsLight.darkColor,
              size: 28,
            ),
          ),
          if (count != null && count! > 0)
            Positioned(
              top: 0,
              left: 0,
              child: Container(
                // padding: const EdgeInsets.all(4),
                width: 16,
                height: 16,
                decoration: const BoxDecoration(
                  color: AppColorsLight.appDarkRedColor,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: TextInAppWidget(
                    text: count.toString(),
                    textSize: 11,
                    textColor: Colors.white,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
