import 'package:flutter/material.dart';
import '../../../../core/helpers/colors/dark_colors.dart';
import '../../../../core/helpers/colors/light_colors.dart';
import '../../../../core/widgets/text_in_app_widget.dart';
import '../../../../core/helpers/constants/constants.dart';
import '../../../../main.dart';
import 'feature_item.dart';

class DescriptionTab extends StatelessWidget {
  const DescriptionTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextInAppWidget(
            text:
                "Supercharged by M2 Pro or M2 Max, MacBook Pro takes its power and efficiency further than ever. It delivers exceptional performance whether it's plugged in or not, and now has even longer battery life.",
            textSize: 15,
            textColor: isDark
                ? AppColorsDark.appTextColor.withValues(alpha: 0.8)
                : AppColorsLight.appTextColor.withValues(alpha: 0.8),
            fontWeightIndex: FontSelectionData.regularFontFamily,
          ),
          const SizedBox(height: 20),
          const FeatureItem(
            icon: Icons.bolt,
            iconColor: Colors.orange,
            text: "Apple M2 Max chip with 12-core CPU and 30-core GPU",
          ),
          const SizedBox(height: 12),
          FeatureItem(
            icon: Icons.memory,
            iconColor: Colors.orange.shade700,
            text: "32GB Unified Memory for intensive multitasking",
          ),
          const SizedBox(height: 12),
          FeatureItem(
            icon: Icons.storage,
            iconColor: Colors.orange.shade800,
            text: "1TB SSD Superfast internal storage",
          ),
        ],
      ),
    );
  }
}
