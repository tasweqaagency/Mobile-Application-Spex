import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spex/core/helpers/colors/dark_colors.dart';
import 'package:spex/core/helpers/colors/light_colors.dart';
import 'package:spex/core/helpers/themes/theme_cubit.dart';
import 'package:spex/generated/locale_keys.g.dart';
import 'package:spex/feature/layout/view_model/layout_cubit/layout_cubit.dart';
import 'package:spex/main.dart';

class AppLayout extends StatefulWidget {
  const AppLayout({super.key});

  @override
  State<AppLayout> createState() => _AppLayoutState();
}

class _AppLayoutState extends State<AppLayout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<LayoutCubit, int>(
        builder: (context, index) {
          return context.read<LayoutCubit>().getScreen(index);
        },
      ),
      bottomNavigationBar: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, state) {
          return BlocBuilder<LayoutCubit, int>(
            builder: (context, currentIndex) {
              return Container(
                height: 70,
                decoration: BoxDecoration(
                  color: isDark
                      ? AppColorsDark.appBgColor
                      : AppColorsLight.whiteColor,
                  // borderRadius: BorderRadius.only(
                  //   topLeft: Radius.circular(30.r),
                  //   topRight: Radius.circular(30.r),
                  // ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 10,
                      offset: const Offset(0, -5),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _NavItem(
                      icon: Icons.home_outlined,
                      label: LocaleKeys.home_home.tr(),
                      index: 0,
                      currentIndex: currentIndex,
                      isDark: isDark,
                    ),
                    _NavItem(
                      icon: Icons.grid_view_outlined,
                      label: LocaleKeys.home_category.tr(),
                      index: 1,
                      currentIndex: currentIndex,
                      isDark: isDark,
                    ),
                    _NavItem(
                      icon: Icons.percent_outlined,
                      label: LocaleKeys.home_promosion.tr(),
                      index: 2,
                      currentIndex: currentIndex,
                      isDark: isDark,
                    ),
                    _NavItem(
                      icon: Icons.add_shopping_cart_outlined,
                      label: LocaleKeys.home_cart.tr(),
                      index: 3,
                      currentIndex: currentIndex,
                      isDark: isDark,
                    ),
                    _NavItem(
                      icon: Icons.person_outline_outlined,
                      label: LocaleKeys.home_profile.tr(),
                      index: 4,
                      currentIndex: currentIndex,
                      isDark: isDark,
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final int index;
  final int currentIndex;
  final bool isDark;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.index,
    required this.currentIndex,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    bool isSelected = index == currentIndex;
    Color activeColor = AppColorsLight.mainColor;
    Color inactiveColor = isDark ? Colors.white70 : Colors.black87;

    return GestureDetector(
      onTap: () => context.read<LayoutCubit>().changeIndex(index),
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: MediaQuery.of(context).size.width / 5,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  size: 22,
                  color: isSelected ? activeColor : inactiveColor,
                ),
                const SizedBox(height: 2),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: isSelected
                        ? FontWeight.bold
                        : FontWeight.normal,
                    color: isSelected ? activeColor : inactiveColor,
                  ),
                ),
                const SizedBox(height: 4), // Space for indicator
              ],
            ),
            if (isSelected)
              Positioned(
                bottom: 2,
                child: Container(
                  height: 4,
                  width: 50,
                  decoration: BoxDecoration(
                    color: activeColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10.r),
                      topRight: Radius.circular(10.r),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
