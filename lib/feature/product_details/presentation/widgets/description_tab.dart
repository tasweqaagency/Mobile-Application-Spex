import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:spex/feature/home/model/product_model.dart';
import '../../../../core/helpers/colors/dark_colors.dart';
import '../../../../core/helpers/colors/light_colors.dart';
import '../../../../core/helpers/fontSelection/font_selection.dart';
import '../../../../main.dart';
import 'feature_item.dart';

class DescriptionTab extends StatelessWidget {
  final SimplifiedProductModel product;
  const DescriptionTab({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HtmlWidget(
            product.description,
            textStyle: TextStyle(
              fontSize: 15,
              color: isDark
                  ? AppColorsDark.appTextColor.withValues(alpha: 0.8)
                  : AppColorsLight.appTextColor.withValues(alpha: 0.8),
              fontFamily: fontSelection(),
            ),
          ),
          // const SizedBox(height: 20),
          // const FeatureItem(
          //   icon: Icons.bolt,
          //   iconColor: Colors.orange,
          //   text: "Apple M2 Max chip with 12-core CPU and 30-core GPU",
          // ),
          // const SizedBox(height: 12),
          // FeatureItem(
          //   icon: Icons.memory,
          //   iconColor: Colors.orange.shade700,
          //   text: "32GB Unified Memory for intensive multitasking",
          // ),
          // const SizedBox(height: 12),
          // FeatureItem(
          //   icon: Icons.storage,
          //   iconColor: Colors.orange.shade800,
          //   text: "1TB SSD Superfast internal storage",
          // ),
        ],
      ),
    );
  }
}
