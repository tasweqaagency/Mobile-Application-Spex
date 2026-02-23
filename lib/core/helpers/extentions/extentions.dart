import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:spex/core/helpers/colors/dark_colors.dart';
import 'package:spex/core/helpers/constants/constants.dart';
import 'package:spex/main.dart';

import '../colors/light_colors.dart';

// extension Navigation on BuildContext {
//   Future<dynamic> pushWidget(Widget page) {
//     return Navigator.of(this).push(NavigateToPageWidget(page));
//   }

//   Future<dynamic> pushReplacementWidget(Widget page) {
//     return Navigator.of(this).pushReplacement(NavigateToPageWidget(page));
//   }

//   Future<dynamic> pushAndRemoveUntilWidget(Widget page) {
//     return Navigator.of(this).pushAndRemoveUntil(
//       NavigateToPageWidget(page),
//       (Route<dynamic> route) => false,
//     );
//   }

//   Future<dynamic> push(String routeName, {Object? arguments}) {
//     return Navigator.of(this).pushNamed(routeName, arguments: arguments);
//   }

//   Future<dynamic> pushReplacement(String routeName, {Object? arguments}) {
//     return Navigator.of(
//       this,
//     ).pushReplacementNamed(routeName, arguments: arguments);
//   }

//   Future<dynamic> pushAndRemoveUntil(String routeName, {Object? arguments}) {
//     return Navigator.of(this).pushNamedAndRemoveUntil(
//       routeName,
//       (Route<dynamic> route) => false,
//       arguments: arguments,
//     );
//   }

//   void pop() => Navigator.of(this).pop(true);
// }
extension Navigation on BuildContext {
  Future<dynamic> pushNamed(String routeName, {Object? arguments}) {
    return Navigator.of(this).pushNamed(routeName, arguments: arguments);
  }

  Future<dynamic> pushReplacementNamed(String routeName, {Object? arguments}) {
    return Navigator.of(
      this,
    ).pushReplacementNamed(routeName, arguments: arguments);
  }

  Future<dynamic> pushNamedAndRemoveUntil(
    String routeName, {
    Object? arguments,
  }) {
    return Navigator.of(this).pushNamedAndRemoveUntil(
      routeName,
      (Route<dynamic> route) => false,
      arguments: arguments,
    );
  }

  void pop({bool? value}) =>
      Navigator.of(this).canPop() ? Navigator.of(this).pop(value) : null;
}

extension StringExtension on String? {
  bool isNullOrEmpty() => this == null || this == "";
}

extension ScreenSize on BuildContext {
  bool get isMobile =>
      MediaQuery.of(this).size.width <= ValuesOfAllApp.mobileWidth;
  bool get isTab => MediaQuery.of(this).size.width <= ValuesOfAllApp.tabWidth;
  double get screenWidth => MediaQuery.of(this).size.width;
  double get screenHeight => MediaQuery.of(this).size.height;
}
// String  generateUuid() {
//   var uuid = const Uuid();
//   return uuid.v4();
// }

SizedBox verticalSpace(double height) => SizedBox(height: height);

SizedBox horizontalSpace(double width) => SizedBox(width: width);
String removePlusFromPhone(String phone) {
  if (phone.startsWith('+')) {
    return phone.substring(1);
  } else {
    return phone;
  }
}

extension DateTimeFormatter on DateTime {
  String toFormattedString() {
    return DateFormat("d/M/yyyy , h:mm a", "ar").format(this);
  }
}

extension StringDateParser on String {
  DateTime toDateTime() {
    return DateFormat("d/M/yyyy , h:mm a", "ar").parse(this);
  }
}

// String formatDateTime(DateTime dateTime) {
//   return DateFormat("d/M/yyyy , h:mm a", "ar").format(dateTime);
// }
// DateTime parseDateTime(String dateString) {
//   return DateFormat("d/M/yyyy , h:mm a", "ar").parse(dateString);
// }

Widget dividerVertical() => Container(
  padding: EdgeInsets.symmetric(vertical: 5.h),
  child: const Divider(color: AppColorsLight.darktGrayColor),
);
Widget dividerHorizontal() => Container(
  padding: EdgeInsets.symmetric(horizontal: 5.h),
  child: const Divider(color: AppColorsLight.lightGrayColor),
);
double mediaQueryHeight(double height, BuildContext context) =>
    MediaQuery.of(context).size.height * (height / 932);

double mediaQueryWidth(double width, BuildContext context) =>
    MediaQuery.of(context).size.width * (width / 430);

BoxDecoration myBoxDecoration({double? opacity, Color? color}) {
  return BoxDecoration(
    color:
        color ??
        (isDark ? AppColorsDark.appSecondBgColor : AppColorsLight.whiteColor),
    borderRadius: BorderRadius.circular(12),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withValues(alpha: 0.05),
        blurRadius: 5,
        offset: const Offset(0, 2),
      ),
    ],
    border: Border.all(
      color: AppColorsLight.appSecondTextColor.withValues(alpha: opacity ?? 0),
    ),
  );
}

BoxDecoration myBoxDecorationWithBorder() {
  return BoxDecoration(
    color: AppColorsLight.whiteColor,
    borderRadius: BorderRadius.circular(12),
    border: Border.all(
      color: AppColorsLight.appSecondTextColor.withValues(alpha: .3),
    ),

    boxShadow: [
      BoxShadow(
        color: Colors.black.withValues(alpha: 0.05),
        blurRadius: 5,
        offset: const Offset(0, 2),
      ),
    ],
  );
}
