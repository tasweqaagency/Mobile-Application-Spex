import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spex/core/helpers/colors/dark_colors.dart';
import 'package:spex/core/helpers/colors/light_colors.dart';
import 'package:spex/core/helpers/constants/constants.dart';
import 'package:spex/core/helpers/extentions/extentions.dart';
import 'package:spex/core/widgets/app_button.dart';
import 'package:spex/core/widgets/app_text_form_field.dart';
import 'package:spex/core/widgets/phone_text_form_widget.dart';
import 'package:spex/core/widgets/text_in_app_widget.dart';
import 'package:spex/feature/shipping_address/model/address_model.dart';
import 'package:spex/generated/locale_keys.g.dart';
import 'package:spex/main.dart';

class AddressDialog extends StatefulWidget {
  final AddressModel? address;
  final Function(AddressModel) onSave;

  const AddressDialog({super.key, this.address, required this.onSave});

  @override
  State<AddressDialog> createState() => _AddressDialogState();
}

class _AddressDialogState extends State<AddressDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _fullNameController;
  late TextEditingController _streetController;
  late TextEditingController _buildingController;
  late TextEditingController _phoneController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.address?.title ?? "");
    _fullNameController = TextEditingController(
      text: widget.address?.fullName ?? "",
    );
    _streetController = TextEditingController(
      text: widget.address?.streetAddress ?? "",
    );
    _buildingController = TextEditingController(
      text: widget.address?.buildingApt ?? "",
    );
    _phoneController = TextEditingController(
      text: widget.address?.phoneNumber ?? "",
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _fullNameController.dispose();
    _streetController.dispose();
    _buildingController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: isDark ? AppColorsDark.appBgColor : Colors.white,
          borderRadius: BorderRadius.circular(30),
        ),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextInAppWidget(
                      text: widget.address == null
                          ? LocaleKeys.address_add_new_address.tr()
                          : LocaleKeys.address_edit_address.tr(),
                      textSize: 20,
                      fontWeightIndex: FontSelectionData.boldFontFamily,
                      textColor: isDark
                          ? AppColorsDark.whiteColor
                          : AppColorsLight.appTextColor,
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.close,
                        color: isDark
                            ? AppColorsDark.appSecondTextColor
                            : Colors.grey[400],
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
                AppTextFormField(
                  textFormController: _titleController,
                  aboveText: LocaleKeys.address_address_title.tr(),
                  keyboardType: TextInputType.text,
                  hintText: LocaleKeys.address_home.tr(),
                  verticalPadding: 12,
                  filledColor: isDark
                      ? AppColorsDark.appSecondBgColor
                      : AppColorsLight.appSecondBgColor.withValues(alpha: 0.3),
                  validator: (value) =>
                      value!.isEmpty ? "Required field" : null,
                ),
                verticalSpace(14),
                AppTextFormField(
                  textFormController: _fullNameController,
                  aboveText: LocaleKeys.address_full_name.tr(),
                  keyboardType: TextInputType.name,
                  hintText: "Enter full name",
                  verticalPadding: 12,
                  filledColor: isDark
                      ? AppColorsDark.appSecondBgColor
                      : AppColorsLight.appSecondBgColor.withValues(alpha: 0.3),
                  validator: (value) =>
                      value!.isEmpty ? "Required field" : null,
                ),
                verticalSpace(14),
                AppTextFormField(
                  textFormController: _streetController,
                  aboveText: LocaleKeys.address_street_address.tr(),
                  keyboardType: TextInputType.streetAddress,
                  hintText: "Enter street address",
                  verticalPadding: 12,
                  filledColor: isDark
                      ? AppColorsDark.appSecondBgColor
                      : AppColorsLight.appSecondBgColor.withValues(alpha: 0.3),
                  validator: (value) =>
                      value!.isEmpty ? "Required field" : null,
                ),
                verticalSpace(14),
                AppTextFormField(
                  textFormController: _buildingController,
                  aboveText: LocaleKeys.address_building_apt.tr(),
                  keyboardType: TextInputType.text,
                  hintText: "Bldg 4, Apt 502",
                  verticalPadding: 12,
                  filledColor: isDark
                      ? AppColorsDark.appSecondBgColor
                      : AppColorsLight.appSecondBgColor.withValues(alpha: 0.3),
                  validator: (value) =>
                      value!.isEmpty ? "Required field" : null,
                ),
                verticalSpace(14),
                PhoneTextFormWidget(
                  aboveText: LocaleKeys.address_phone_number.tr(),
                  controller: _phoneController,
                  initialNumber: _phoneController.text.isNotEmpty
                      ? _phoneController.text
                      : null,
                ),
                verticalSpace(32),
                Row(
                  children: [
                    Expanded(
                      child: AppTextButton(
                        buttonText: LocaleKeys.address_cancel.tr(),
                        backgroundColor: isDark
                            ? AppColorsDark.appSecondBgColor
                            : AppColorsLight.appSecondBgColor.withValues(
                                alpha: 0.3,
                              ),
                        textStyle: TextStyle(
                          color: isDark
                              ? AppColorsDark.whiteColor
                              : AppColorsLight.appSecondTextColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                    horizontalSpace(16),
                    Expanded(
                      child: AppTextButton(
                        buttonText: LocaleKeys.address_save_changes.tr(),
                        backgroundColor: AppColorsLight.mainColor,
                        textStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            final newAddress = AddressModel(
                              id:
                                  widget.address?.id ??
                                  DateTime.now().millisecondsSinceEpoch
                                      .toString(),
                              title: _titleController.text,
                              fullName: _fullNameController.text,
                              streetAddress: _streetController.text,
                              buildingApt: _buildingController.text,
                              city: widget.address?.city ?? "Cairo, Egypt",
                              phoneNumber: _phoneController.text,
                              isDefault: widget.address?.isDefault ?? false,
                            );
                            widget.onSave(newAddress);
                            Navigator.pop(context);
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
