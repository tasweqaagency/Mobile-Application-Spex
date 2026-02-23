import 'package:flutter/material.dart';
import 'package:spex/core/helpers/colors/dark_colors.dart';
import 'package:spex/core/helpers/colors/light_colors.dart';
import 'package:spex/core/helpers/constants/constants.dart';
import 'package:spex/core/helpers/extentions/extentions.dart';
import 'package:spex/core/widgets/text_in_app_widget.dart';
import 'package:spex/main.dart';

class ProfileInfoWidget extends StatelessWidget {
  final String name;
  final String? avatarUrl;

  const ProfileInfoWidget({
    super.key,
    required this.name,
    this.avatarUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              padding: EdgeInsets.all(4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColorsLight.mainColor.withValues(alpha: 0.2),
                  width: 2,
                ),
              ),
              child: CircleAvatar(
                radius: 40,
                backgroundColor: isDark?AppColorsDark.appSecondBgColor:AppColorsLight.mainLightColor,
                backgroundImage: avatarUrl != null
                    ? NetworkImage(avatarUrl!)
                    : null,
                child: avatarUrl == null
                    ? Icon(
                        Icons.person,
                        size: 40,
                        color: AppColorsLight.mainColor,
                      )
                    : null,
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.all(4),
                decoration: const BoxDecoration(
                  color: AppColorsLight.mainColor,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.edit, size: 16, color: Colors.white),
              ),
            ),
          ],
        ),
        verticalSpace(16),
        TextInAppWidget(
          text: name,
          textSize: 22,
          fontWeightIndex: FontSelectionData.boldFontFamily,
          textColor: isDark?AppColorsDark.appTextColor:AppColorsLight.appTextColor,
        ),
      ],
    );
  }
}
