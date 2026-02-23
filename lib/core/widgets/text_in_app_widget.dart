import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../helpers/fontSelection/font_selection.dart';

class TextInAppWidget extends StatelessWidget {
  const TextInAppWidget({
    super.key,
    required this.text,
    this.textColor,
    this.textSize,
    this.textWidth,
    this.isTextCenter,
    this.textAlign,
    this.fontWeightIndex,
    this.isEllipsisTextOverflow,
    this.maxLines,
    this.textDecoration,
    this.decorationThickness,
    this.decorationColor,
  });

  final String text;
  final Color? textColor;
  final double? textSize;
  final double? textWidth;
  final bool? isTextCenter;
  final TextAlign? textAlign;
  final int? fontWeightIndex;
  final bool? isEllipsisTextOverflow;
  final int? maxLines;
  final TextDecoration? textDecoration;
  final double? decorationThickness;
  final Color? decorationColor;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: textWidth,
      child: Text(
        text,
        textAlign:
            textAlign ??
            (isTextCenter == true ? TextAlign.center : TextAlign.start),
        maxLines: maxLines,
        style: TextStyle(
          overflow: isEllipsisTextOverflow == true
              ? TextOverflow.ellipsis
              : null,
          fontSize: textSize != null
              ? (context.locale.languageCode == 'ar' ? textSize : textSize! - 1)
              : (context.locale.languageCode == 'ar'
                    ? size.width * 0.05
                    : size.width * 0.04),
          fontWeight: fontWeightSelection(fontWeightIndex: fontWeightIndex),
          color: textColor,
          fontFamily: fontSelection(),
          decoration: textDecoration,
          decorationThickness: decorationThickness,
          decorationColor: decorationColor,
        ),
      ),
    );
  }
}
