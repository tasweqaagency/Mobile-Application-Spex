import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spex/core/helpers/colors/light_colors.dart';
import 'package:spex/core/helpers/colors/dark_colors.dart';
import 'package:spex/core/helpers/constants/constants.dart';
import 'package:spex/core/helpers/extentions/extentions.dart';
import 'package:spex/core/helpers/fontSelection/font_selection.dart';
import 'package:spex/core/helpers/fontSelection/font_selection.dart' as FontSelection;
import 'package:spex/core/helpers/themes/text_styles.dart';
import 'package:spex/core/routing/routing.dart';
import 'package:spex/generated/locale_keys.g.dart';
import 'package:spex/main.dart';
import 'dart:ui' as ui;

class CustomSearchBar extends StatefulWidget {
  final String hintText;
  final ValueChanged<String>? onChanged;
  final EdgeInsetsGeometry? padding;
  final Color? backgroundColor;
  final double? height;
  final bool isRealSearch;
  final bool isAutoFocus;
  const CustomSearchBar({
    super.key,
    required this.hintText,
    this.onChanged,
    this.padding,
    this.backgroundColor,
    this.height,
    this.isRealSearch = false,
    this.isAutoFocus = false,
  });

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var searchField = Directionality(
      textDirection: context.locale.languageCode == 'ar'
          ? ui.TextDirection.rtl
          : ui.TextDirection.ltr,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50.r),
        child: Container(
          padding:
              widget.padding ??
              const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          width: double.infinity,
          height: widget.height ?? 75,
          color:
              widget.backgroundColor ??
              (isDark ? AppColorsDark.appBgColor : AppColorsLight.mainLightColor),
          child: TextFormField(
            style: TextStyles.font14blackRreg.copyWith(
              fontFamily: FontSelection.fontSelection(),
              color: isDark ? AppColorsDark.appTextColor : AppColorsLight.appTextColor,
            ),
            controller: _controller,
            keyboardType: TextInputType.text,
            autofocus: widget.isAutoFocus,
            enabled: widget.isRealSearch,
            onChanged: (value) {
              if (widget.onChanged != null) {
                widget.onChanged!(value);
              }
            },

            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(
                left: 20,
                right: 20,
                top: 10,
                bottom: 10,
              ),
              fillColor: isDark
                  ? AppColorsDark.appSecondBgColor
                  : AppColorsLight.whiteColor,

              filled: true,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50),
                borderSide: BorderSide(
                  color: isDark
                      ? AppColorsDark.appSecondBgColor
                      : AppColorsLight.whiteColor,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50),
                borderSide: BorderSide(
                  color: isDark
                      ? AppColorsDark.appSecondBgColor
                      : AppColorsLight.whiteColor,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50),
                borderSide: BorderSide(
                  color: isDark
                      ? AppColorsDark.appSecondBgColor
                      : AppColorsLight.whiteColor,
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50),
                borderSide: BorderSide(
                  color: isDark
                      ? AppColorsDark.appSecondBgColor
                      : AppColorsLight.whiteColor,
                ),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50),
                borderSide: BorderSide(
                  color: isDark
                      ? AppColorsDark.appSecondBgColor
                      : AppColorsLight.whiteColor,
                ),
              ),
              suffixIcon: Container(
                margin: EdgeInsets.all(3),
                // width: 20,
                // height: 20,
                decoration: BoxDecoration(
                  color: AppColorsLight.mainColor,
                  borderRadius: BorderRadius.circular(50.r),
                ),
                child: Icon(Icons.search, color: AppColorsLight.whiteColor),
              ),
              hintText: LocaleKeys.home_search.tr(),
              hintStyle: TextStyle(
                color: isDark
                    ? Colors.white70
                    : AppColorsLight.appDarkGrayColor,
                fontSize: 14,
                fontFamily: fontSelection(),
              ),
              // errorStyle: const TextStyle(height: 0, fontSize: 0),
            ),
          ),
        ),
      ),
    );
    // When not in real search mode, wrap with GestureDetector to navigate
    if (!widget.isRealSearch) {
      return GestureDetector(
        onTap: () {
          context.pushNamed(Routes.searchScreen);
        },
        child: AbsorbPointer(child: searchField),
      );
    }

    return searchField;
  }
}
