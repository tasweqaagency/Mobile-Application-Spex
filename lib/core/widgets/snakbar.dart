import 'package:flutter/material.dart';
import 'package:spex/core/widgets/text_in_app_widget.dart';
import 'dart:async';

import 'package:spex/core/helpers/colors/light_colors.dart';
import 'package:spex/core/helpers/constants/constants.dart';
import '../../main.dart';

class AppSnackBar {
  static void showSuccess(String message) {
    _show(message, Colors.green);
  }

  static void showError(String message) {
    _show(message, Colors.red);
  }

  static void showInfo(String message) {
    _show(message, AppColorsLight.greenColor);
  }

  static void showWarning(String message) {
    _show(message, Colors.brown);
  }

  static void _show(String message, Color color) {
    if (snackBarKey.currentState != null) {
      snackBarKey.currentState!.hideCurrentSnackBar();
      snackBarKey.currentState!.showSnackBar(
        SnackBar(
          content: TextInAppWidget(
            text: message,
            textSize: 14,
            textColor: AppColorsLight.whiteColor,
            fontWeightIndex: FontSelectionData.semiBoldFontFamily,
          ),

          backgroundColor: color,
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          margin: const EdgeInsets.only(left: 16, right: 16, bottom: 50),
        ),
      );
    }
  }
}

class AppToast {
  static OverlayEntry? _overlayEntry;
  static Timer? _timer;

  static void showError(BuildContext context, String message) {
    _show(context, message, Colors.red);
  }

  static void showSuccess(BuildContext context, String message) {
    _show(context, message, Colors.green);
  }

  static void showWarning(BuildContext context, String message) {
    _show(context, message, Colors.orange);
  }

  static void _show(BuildContext context, String message, Color color) {
    // Try to get overlay from context
    OverlayState? overlayState = Overlay.maybeOf(context);

    // If context is gone (EdfaPay dialogs), fallback to global overlay
    overlayState ??= WidgetsBinding.instance.rootElement
        ?.findAncestorStateOfType<OverlayState>();

    if (overlayState == null) {
      print("⚠ NO OVERLAY AVAILABLE → Toast cancelled safely");
      return;
    }

    // Cancel previous timer
    _timer?.cancel();

    // Remove previous toast safely
    if (_overlayEntry != null) {
      try {
        if (_overlayEntry!.mounted) {
          _overlayEntry!.remove();
        }
      } catch (_) {}
      _overlayEntry = null;
    }

    // New toast
    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        bottom: 80,
        left: 20,
        right: 20,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(12),
            ),
            child: TextInAppWidget(
              text: message,
              textSize: 14,
              textColor: Colors.white,
              fontWeightIndex: FontSelectionData.semiBoldFontFamily,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );

    // Insert safely
    overlayState.insert(_overlayEntry!);

    // Auto remove
    _timer = Timer(const Duration(seconds: 3), () {
      try {
        if (_overlayEntry != null && _overlayEntry!.mounted) {
          _overlayEntry!.remove();
        }
      } catch (_) {}
      _overlayEntry = null;
    });
  }
}
