import 'package:flutter/material.dart';
import 'package:spex/core/helpers/constants/constants.dart';
import 'package:spex/core/widgets/text_in_app_widget.dart';

class ProductLabelFlagWidget extends StatelessWidget {
  const ProductLabelFlagWidget({
    super.key,
    required this.text,
    required this.color,
  });
  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextInAppWidget(
        text: text,
        textSize: 10,
        fontWeightIndex: FontSelectionData.boldFontFamily,
        textColor: Colors.white,
      ),
    );
  }
}
