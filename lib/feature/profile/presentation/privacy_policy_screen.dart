import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spex/core/helpers/colors/dark_colors.dart';
import 'package:spex/core/helpers/colors/light_colors.dart';
import 'package:spex/feature/home/presentation/widgets/my_appbar.dart';
import 'package:spex/generated/locale_keys.g.dart';
import 'package:spex/main.dart';
import 'widgets/policy_item_widget.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isDark
          ? AppColorsDark.appBgColor
          : AppColorsLight.appBgColor,
      appBar: MyAppBarWithBackButton(
        title: LocaleKeys.policy_privacy_policy_title.tr(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PolicyItemWidget(
                title: LocaleKeys.policy_privacy_item_1_title.tr(),
                body: LocaleKeys.policy_privacy_item_1_body.tr(),
              ),
              PolicyItemWidget(
                title: LocaleKeys.policy_privacy_item_2_title.tr(),
                body: LocaleKeys.policy_privacy_item_2_body.tr(),
              ),
              PolicyItemWidget(
                title: LocaleKeys.policy_privacy_item_3_title.tr(),
                body: LocaleKeys.policy_privacy_item_3_body.tr(),
              ),
              PolicyItemWidget(
                title: LocaleKeys.policy_privacy_item_4_title.tr(),
                body: LocaleKeys.policy_privacy_item_4_body.tr(),
              ),
              PolicyItemWidget(
                title: LocaleKeys.policy_privacy_item_5_title.tr(),
                body: LocaleKeys.policy_privacy_item_5_body.tr(),
              ),
              PolicyItemWidget(
                title: LocaleKeys.policy_privacy_item_6_title.tr(),
                body: LocaleKeys.policy_privacy_item_6_body.tr(),
              ),
              PolicyItemWidget(
                title: LocaleKeys.policy_privacy_item_7_title.tr(),
                body: LocaleKeys.policy_privacy_item_7_body.tr(),
              ),
              PolicyItemWidget(
                title: LocaleKeys.policy_privacy_item_8_title.tr(),
                body: LocaleKeys.policy_privacy_item_8_body.tr(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
