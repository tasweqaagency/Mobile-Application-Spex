import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spex/core/helpers/colors/dark_colors.dart';
import 'package:spex/core/helpers/colors/light_colors.dart';
import 'package:spex/core/helpers/constants/constants.dart';
import 'package:spex/core/helpers/extentions/extentions.dart';
import 'package:spex/core/widgets/text_in_app_widget.dart';
import 'package:spex/feature/home/presentation/widgets/custom_search_bar.dart';
import 'package:spex/feature/home/presentation/widgets/notification_icon_button.dart';
import 'package:spex/generated/locale_keys.g.dart';
import 'package:spex/main.dart';
import 'package:spex/core/routing/routing.dart';

class MyHomeAppBar extends StatelessWidget {
  const MyHomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    double expandedHeight = 140;
    final double statusBarHeight = MediaQuery.of(context).padding.top;

    return Directionality(
      textDirection: ui.TextDirection.ltr,
      child: SliverAppBar(
        expandedHeight: expandedHeight,
        floating: false,
        pinned: true,
        backgroundColor: isDark
            ? AppColorsDark.appBgColor
            : AppColorsLight.mainLightColor,
        automaticallyImplyLeading: false,
        elevation: 0,
        // actions: [NotificationIconButton(count: 2, onTap: () {})],
        flexibleSpace: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            final double currentHeight = constraints.maxHeight;
            final double scrollProgress =
                ((currentHeight - kToolbarHeight - statusBarHeight) /
                        (expandedHeight - kToolbarHeight - statusBarHeight))
                    .clamp(0.0, 1.0);

            // Interpolated values for the Search Bar
            final double left =
                90.0 +
                (0.0 - 90.0) * scrollProgress; // 90 collapsed, 0 expanded
            final double right =
                50.0 +
                (0.0 - 50.0) * scrollProgress; // 50 collapsed, 0 expanded

            final double collapsedTop =
                statusBarHeight + (kToolbarHeight - 42) / 2;
            final double expandedTop =
                expandedHeight - 75 - 4; // Bottom-shifted
            final double top =
                collapsedTop +
                (expandedTop - collapsedTop + 30.w) * scrollProgress;

            final double height = 42.0 + (75.0 - 42.0) * scrollProgress;

            final double horizontalPadding =
                4.0 + (12.0 - 4.0) * scrollProgress;
            final double verticalPadding = 2.0 + (12.0 - 2.0) * scrollProgress;

            // Interpolated values for the Logo
            final double logoHeight = 70.0 + (30.0 * scrollProgress);
            final double logoWidth = 70.0 + (40.0 * scrollProgress);
            final double logoTop =
                statusBarHeight + (kToolbarHeight - logoHeight) / 2;

            return Container(
              color: isDark
                  ? AppColorsDark.appBgColor
                  : AppColorsLight.mainLightColor,
              child: Stack(
                children: [
                  // Logo - Animated Size
                  Positioned(
                    left: 14,
                    top: logoTop,
                    child: Image.asset(
                      AppImages.appLogoImagePath,
                      height: logoHeight,
                      width: logoWidth,
                      fit: BoxFit.contain,
                      color: AppColorsLight.secondColor,
                    ),
                  ),

                  // Single Animated Search Bar
                  Positioned(
                    left: left,
                    right: right,
                    top: top,
                    child: CustomSearchBar(
                      hintText: LocaleKeys.home_search_hint.tr(),
                      height: height,
                      padding: EdgeInsets.symmetric(
                        horizontal: horizontalPadding,
                        vertical: verticalPadding,
                      ),
                      backgroundColor: scrollProgress > 0.5
                          ? (isDark
                                ? AppColorsDark.appBgColor
                                : AppColorsLight.mainLightColor)
                          : Colors.transparent,
                    ),
                  ),

                  // Notification Icon - Absolute position to maintain LTR regardless of system direction
                  Positioned(
                    right: 4,
                    top: statusBarHeight + (kToolbarHeight - 48) / 2,
                    child: NotificationIconButton(
                      count: 2,
                      onTap: () {
                        context.pushNamed(Routes.notificationScreen);
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class MyAppBarWithBackButton extends StatelessWidget
    implements PreferredSizeWidget {
  const MyAppBarWithBackButton({
    super.key,
    this.title,
    this.isRealSearch = false,
    this.isAutoFocus = false,
    this.bottom,
    this.showSearch = true,
  });
  final String? title;
  final bool isRealSearch;
  final bool isAutoFocus;
  final PreferredSizeWidget? bottom;
  final bool showSearch;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: ui.TextDirection.ltr,
      child: AppBar(
        backgroundColor: isDark
            ? AppColorsDark.appBgColor
            : AppColorsLight.mainLightColor,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(
              Icons.arrow_back_ios_new_outlined,
              color: isDark ? Colors.white : AppColorsLight.darkColor,
              size: 22,
            ),
            onPressed: () => context.pop(),
          ),
        ),
        centerTitle: true,
        title: title != null && !showSearch
            ? TextInAppWidget(
                text: title!,
                textSize: 16,
                fontWeightIndex: FontSelectionData.regularFontFamily,
                textColor: isDark ? Colors.white : AppColorsLight.darkColor,
              )
            : CustomSearchBar(
                isRealSearch: isRealSearch,
                hintText: LocaleKeys.home_search_hint.tr(),
                height: 42,
                padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                backgroundColor: isDark
                    ? AppColorsDark.appBgColor
                    : AppColorsLight.mainLightColor,
                isAutoFocus: isAutoFocus,
              ),
        actions: [
          NotificationIconButton(
            count: 2,
            onTap: () {
              context.pushNamed(Routes.notificationScreen);
            },
          ),
        ],
        bottom: bottom,
      ),
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(kToolbarHeight + (bottom?.preferredSize.height ?? 0));
}

class MyAppBarWithLogo extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBarWithLogo({super.key, this.title, this.isRealSearch = false});
  final String? title;
  final bool isRealSearch;
  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    final double logoHeight = 70.0;
    final double logoWidth = 70.0;
    final double logoTop = statusBarHeight + (kToolbarHeight - logoHeight) / 2;

    return PreferredSize(
      preferredSize: const Size.fromHeight(kToolbarHeight),
      child: Directionality(
        textDirection: ui.TextDirection.ltr,
        child: AppBar(
          backgroundColor: isDark
              ? AppColorsDark.appBgColor
              : AppColorsLight.mainLightColor,
          elevation: 0,
          scrolledUnderElevation: 0,
          surfaceTintColor: Colors.transparent,
          automaticallyImplyLeading: false,
          actions: [
            NotificationIconButton(
              count: 2,
              onTap: () {
                context.pushNamed(Routes.notificationScreen);
              },
            ),
          ],
          flexibleSpace: Container(
            color: isDark
                ? AppColorsDark.appBgColor
                : AppColorsLight.mainLightColor,
            child: Stack(
              children: [
                Positioned(
                  left: 14,
                  top: logoTop,
                  child: Image.asset(
                    AppImages.appLogoImagePath,
                    height: logoHeight,
                    width: logoWidth,
                    fit: BoxFit.contain,
                    color: AppColorsLight.secondColor,
                  ),
                ),
                Positioned(
                  left: 90.0,
                  right: 50.0,
                  top: statusBarHeight + (kToolbarHeight - 42) / 2,
                  child: CustomSearchBar(
                    isRealSearch: isRealSearch,
                    hintText: LocaleKeys.home_search_hint.tr(),
                    height: 42,
                    padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                    backgroundColor: isDark
                        ? AppColorsDark.appBgColor
                        : AppColorsLight.mainLightColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
