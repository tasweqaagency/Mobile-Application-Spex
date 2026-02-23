import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spex/core/helpers/themes/theme_cubit.dart';
import 'package:spex/core/helpers/colors/dark_colors.dart';
import 'package:spex/core/helpers/colors/light_colors.dart';
import 'package:spex/core/helpers/constants/constants.dart';
import 'package:spex/core/helpers/extentions/extentions.dart';
import 'package:spex/core/routing/routing.dart';
import 'package:spex/core/widgets/text_in_app_widget.dart';
import 'package:spex/feature/home/presentation/widgets/my_appbar.dart';
import 'package:spex/generated/locale_keys.g.dart';
import 'package:spex/main.dart';
import 'widgets/profile_info_widget.dart';
import 'widgets/profile_stats_row.dart';
import 'widgets/profile_menu_section.dart';
import 'widgets/logout_button.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, state) {
        return Scaffold(
          appBar: MyAppBarWithLogo(),
          body: SingleChildScrollView(
            child: Column(
              children: [
                verticalSpace(28),
                ProfileInfoWidget(name: "Ahmed Mansour"),
                verticalSpace(32),
                ProfileStatsRow(
                  ordersCount: "12",
                  couponsCount: "5",
                  pointsCount: "2.4k",
                ),
                verticalSpace(32),
                ProfileMenuSection(
                  items: [
                    ProfileMenuItem(
                      icon: Icons.shopping_bag_outlined,
                      title: LocaleKeys.home_orders.tr(),
                      onTap: () {
                        context.pushNamed(Routes.myOrdersScreen);
                      },
                      iconBgColor: AppColorsLight.profileMyOrdersBg,
                      iconColor: AppColorsLight.profileMyOrdersIcon,
                    ),
                    ProfileMenuItem(
                      icon: Icons.favorite_border,
                      title: LocaleKeys.home_favorite.tr(),
                      onTap: () {
                        context.pushNamed(Routes.favoriteScreen);
                      },
                      iconBgColor: AppColorsLight.profileWishlistBg,
                      iconColor: AppColorsLight.profileWishlistIcon,
                    ),
                    ProfileMenuItem(
                      icon: Icons.location_on_outlined,
                      title: LocaleKeys.orders_shipping_address.tr(),
                      onTap: () {
                        context.pushNamed(Routes.shippingAddressesScreen);
                      },
                      iconBgColor: AppColorsLight.profileShippingAddressBg,
                      iconColor: AppColorsLight.profileShippingAddressIcon,
                    ),
                  ],
                ),
                verticalSpace(24),
                Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: TextInAppWidget(
                      text: LocaleKeys.profile_preferences.tr(),
                      textSize: 14,
                      textColor: isDark
                          ? AppColorsDark.appSecondTextColor
                          : AppColorsLight.appSecondTextColor,
                      fontWeightIndex: FontSelectionData.boldFontFamily,
                    ),
                  ),
                ),
                verticalSpace(12),
                ProfileMenuSection(
                  items: [
                    ProfileMenuItem(
                      icon: Icons.language,
                      title: LocaleKeys.profile_language.tr(),
                      onTap: () {
                        if (context.locale.languageCode == 'en') {
                          context.setLocale(const Locale('ar'));
                        } else {
                          context.setLocale(const Locale('en'));
                        }
                      },
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextInAppWidget(
                            text: context.locale.languageCode == 'en'
                                ? LocaleKeys.profile_english.tr()
                                : LocaleKeys.profile_arabic.tr(),
                            textSize: 14,
                            textColor: isDark
                                ? AppColorsDark.appSecondTextColor
                                : Colors.grey[600],
                          ),
                          horizontalSpace(8),
                          Icon(
                            Icons.keyboard_arrow_down,
                            color: isDark
                                ? AppColorsDark.appSecondTextColor
                                : Colors.grey[400],
                            size: 20,
                          ),
                        ],
                      ),
                      iconBgColor: AppColorsLight.profilePaymentMethodsBg,
                      iconColor: AppColorsLight.profilePaymentMethodsIcon,
                    ),
                    ProfileMenuItem(
                      icon: Icons.dark_mode_outlined,
                      title: LocaleKeys.profile_dark_mode.tr(),
                      onTap: () {},
                      trailing: Transform.scale(
                        scale: 0.8,
                        child: Switch(
                          value: state == ThemeMode.dark,
                          activeThumbColor: AppColorsLight.mainColor,
                          onChanged: (val) {
                            context.read<ThemeCubit>().changeTheme(val);
                          },
                        ),
                      ),
                      iconBgColor: AppColorsLight.profileSettingsBg,
                      iconColor: AppColorsLight.profileSettingsIcon,
                    ),
                  ],
                ),
                verticalSpace(24),
                Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: TextInAppWidget(
                      text: LocaleKeys.profile_support_legal.tr(),
                      textSize: 14,
                      textColor: isDark
                          ? AppColorsDark.appSecondTextColor
                          : AppColorsLight.appSecondTextColor,
                      fontWeightIndex: FontSelectionData.boldFontFamily,
                    ),
                  ),
                ),
                verticalSpace(12),
                ProfileMenuSection(
                  items: [
                    ProfileMenuItem(
                      icon: Icons.security_outlined,
                      title: LocaleKeys.profile_privacy_policy.tr(),
                      onTap: () {},
                      iconBgColor: AppColorsLight.profileShippingAddressBg,
                      iconColor: AppColorsLight.profileShippingAddressIcon,
                    ),
                    ProfileMenuItem(
                      icon: Icons.description_outlined,
                      title: LocaleKeys.profile_terms_of_service.tr(),
                      onTap: () {},
                      iconBgColor: AppColorsLight.profileWishlistBg,
                      iconColor: AppColorsLight.profileWishlistIcon,
                    ),
                  ],
                ),
                verticalSpace(28),
                LogoutButton(onTap: () {}),
                verticalSpace(28),
              ],
            ),
          ),
        );
      },
    );
  }
}
