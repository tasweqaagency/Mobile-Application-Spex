import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spex/core/helpers/colors/dark_colors.dart';
import 'package:spex/core/helpers/colors/light_colors.dart';
import 'package:spex/core/helpers/constants/constants.dart';
import 'package:spex/core/helpers/extentions/extentions.dart';
import 'package:spex/core/widgets/text_in_app_widget.dart';
import 'package:spex/feature/shipping_address/model/address_model.dart';
import 'package:spex/generated/locale_keys.g.dart';
import 'package:spex/main.dart';

import 'package:spex/feature/shipping_address/presentation/widgets/address_action_button.dart';

class AddressCard extends StatelessWidget {
  final AddressModel address;
  final bool isSelected;
  final VoidCallback onTap;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const AddressCard({
    super.key,
    required this.address,
    required this.isSelected,
    required this.onTap,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isDark
              ? AppColorsDark.appSecondBgColor
              : AppColorsLight.whiteColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? AppColorsLight.mainColor : Colors.transparent,
            width: 1.5,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  isSelected
                      ? Icons.radio_button_checked
                      : Icons.radio_button_off,
                  color: isSelected
                      ? AppColorsLight.mainColor
                      : (isDark ? Colors.grey[600] : Colors.grey[400]),
                  size: 20,
                ),
                horizontalSpace(8),
                TextInAppWidget(
                  text: address.title,
                  textSize: 16,
                  fontWeightIndex: FontSelectionData.boldFontFamily,
                  textColor: isDark
                      ? AppColorsDark.whiteColor
                      : AppColorsLight.appTextColor,
                ),
                const Spacer(),
                if (address.isDefault)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: AppColorsLight.mainColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: TextInAppWidget(
                      text: LocaleKeys.address_default.tr(),
                      textSize: 10,
                      fontWeightIndex: FontSelectionData.boldFontFamily,
                      textColor: AppColorsLight.mainColor,
                    ),
                  ),
              ],
            ),
            verticalSpace(12),
            TextInAppWidget(
              text: address.fullName,
              textSize: 14,
              fontWeightIndex: FontSelectionData.boldFontFamily,
              textColor: isDark
                  ? AppColorsDark.whiteColor
                  : AppColorsLight.appTextColor,
            ),
            verticalSpace(4),
            TextInAppWidget(
              text:
                  "${address.streetAddress}, ${address.buildingApt}\n${address.city}",
              textSize: 13,
              textColor: isDark
                  ? AppColorsDark.appSecondTextColor
                  : AppColorsLight.appSecondTextColor,
            ),
            verticalSpace(8),
            Row(
              children: [
                Icon(
                  Icons.phone_outlined,
                  size: 14,
                  color: isDark
                      ? AppColorsDark.appSecondTextColor
                      : AppColorsLight.appSecondTextColor,
                ),
                horizontalSpace(8),
                TextInAppWidget(
                  text: address.phoneNumber,
                  textSize: 13,
                  textColor: isDark
                      ? AppColorsDark.appSecondTextColor
                      : AppColorsLight.appSecondTextColor,
                ),
              ],
            ),
            verticalSpace(16),
            dividerHorizontal(),
            verticalSpace(12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                AddressActionButton(
                  icon: Icons.edit_outlined,
                  label: LocaleKeys.cart_edit.tr(),
                  onPressed: onEdit,
                  color: isDark
                      ? AppColorsDark.whiteColor
                      : AppColorsLight.appTextColor,
                ),
                Container(
                  width: 1,
                  height: 20,
                  color: isDark ? Colors.grey[800] : Colors.grey[200],
                ),
                AddressActionButton(
                  icon: Icons.delete_outline,
                  label: LocaleKeys.address_delete.tr(),
                  onPressed: onDelete,
                  color: AppColorsLight.appDarkRedColor,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
