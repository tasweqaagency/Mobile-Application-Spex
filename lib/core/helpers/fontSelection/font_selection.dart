import 'package:flutter/material.dart';

import '../constants/constants.dart';

String? fontSelection({String? fontFamily}) {
  if (fontFamily == null) return AppFonts.lexendDecaFontFamily;
  return fontFamily;
}

FontWeight? fontWeightSelection({int? fontWeightIndex}) {
  if (fontWeightIndex == FontSelectionData.boldFontFamily) {
    return FontWeight.w700;
  } else if (fontWeightIndex == FontSelectionData.semiBoldFontFamily) {
    return FontWeight.w600;
  } else if (fontWeightIndex == FontSelectionData.regularFontFamily) {
    return FontWeight.w500;
  }
  return null;
}

class AppFonts {
  static const String lexendDecaFontFamily = 'LexendDeca';
}
