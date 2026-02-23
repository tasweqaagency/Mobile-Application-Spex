import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:spex/core/helpers/colors/light_colors.dart';
import 'package:spex/core/widgets/text_in_app_widget.dart';
import 'drawer_item.dart';
import 'package:spex/generated/locale_keys.g.dart';
import 'package:spex/core/helpers/constants/constants.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: Column(
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(color: AppColorsLight.mainColor),
            child: Center(
              child: TextInAppWidget(
                text: AppConstants.APP_NAME,
                textSize: 32,
                fontWeightIndex: FontSelectionData.boldFontFamily,
                textColor: Colors.white,
              ),
            ),
          ),
          DrawerItem(
            icon: Icons.home_outlined,
            title: LocaleKeys.home_home.tr(),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          DrawerItem(
            icon: Icons.person_outline,
            title: LocaleKeys.home_profile.tr(),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          DrawerItem(
            icon: Icons.shopping_bag_outlined,
            title: LocaleKeys.home_orders.tr(),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          DrawerItem(
            icon: Icons.favorite_border,
            title: LocaleKeys.home_favorite.tr(),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          DrawerItem(
            icon: Icons.settings_outlined,
            title: LocaleKeys.home_settings.tr(),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          const Spacer(),
          const Divider(),
          ListTile(
            leading: const Icon(
              Icons.logout,
              color: AppColorsLight.appDarkRedColor,
            ),
            title: TextInAppWidget(
              text: LocaleKeys.home_logout.tr(),
              textSize: 16,
              textColor: AppColorsLight.appDarkRedColor,
              fontWeightIndex: FontSelectionData.semiBoldFontFamily,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
