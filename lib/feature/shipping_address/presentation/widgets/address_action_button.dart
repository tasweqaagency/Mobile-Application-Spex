import 'package:flutter/material.dart';
import '../../../../core/helpers/constants/constants.dart';
import '../../../../core/helpers/extentions/extentions.dart';
import '../../../../core/widgets/text_in_app_widget.dart';

class AddressActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;
  final Color color;

  const AddressActionButton({
    super.key,
    required this.icon,
    required this.label,
    required this.onPressed,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18, color: color),
          horizontalSpace(8),
          TextInAppWidget(
            text: label,
            textSize: 14,
            fontWeightIndex: FontSelectionData.boldFontFamily,
            textColor: color,
          ),
        ],
      ),
    );
  }
}
