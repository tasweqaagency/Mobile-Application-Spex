import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_contact_picker/flutter_native_contact_picker.dart';
import 'package:flutter_native_contact_picker/model/contact.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import 'dart:ui' as ui;

import 'package:spex/core/helpers/colors/light_colors.dart';
import 'package:spex/core/helpers/colors/dark_colors.dart';
import 'package:spex/main.dart';
import 'package:spex/core/helpers/extentions/extentions.dart';
import 'package:spex/core/helpers/themes/text_styles.dart';
import 'package:spex/core/widgets/text_in_app_widget.dart';
import 'package:spex/core/helpers/constants/constants.dart';

class PhoneTextFormWidget extends StatefulWidget {
  PhoneTextFormWidget({
    super.key,
    this.aboveText,
    required this.controller,
    this.initialCountry = 'EG',
    this.initialNumber,
    this.showContactIcon = false,
  });
  final String? aboveText;
  TextEditingController? controller;
  String? initialCountry;
  String? initialNumber;
  final bool showContactIcon;

  @override
  State<PhoneTextFormWidget> createState() => _PhoneTextFormWidgetState();
}

class _PhoneTextFormWidgetState extends State<PhoneTextFormWidget> {
  @override
  Widget build(BuildContext context) {
    final FlutterNativeContactPicker contactPicker =
        FlutterNativeContactPicker();

    Future<void> pickContact() async {
      try {
        final Contact? contact = await contactPicker.selectContact();
        if (contact == null || contact.phoneNumbers?.isEmpty == true) return;

        String rawNumber = contact.phoneNumbers!.first;
        String cleaned = _normalizePhoneNumber(rawNumber);

        setState(() {
          widget.controller?.text = cleaned;
          final parsed = parsePhone(widget.controller!.text);
          widget.initialCountry = parsed['countryCode']!;
          widget.initialNumber = parsed['number']!;
        });
      } catch (e) {
        debugPrint('Contact pick failed: $e');
      }
    }

    return Directionality(
      textDirection: ui.TextDirection.ltr,
      child: Column(
        crossAxisAlignment: context.locale.languageCode == "en"
            ? CrossAxisAlignment.start
            : CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: TextInAppWidget(
              text: widget.aboveText ?? "",
              textSize: 15,
              fontWeightIndex: FontSelectionData.semiBoldFontFamily,
              textColor: isDark
                  ? AppColorsDark.appTextColor
                  : AppColorsLight.appTextColor,
            ),
          ),
          verticalSpace(5),
          IntlPhoneField(
            key: ValueKey("${widget.initialCountry}_${widget.initialNumber}"),
            initialCountryCode: widget.initialCountry,
            initialValue: widget.initialNumber,
            invalidNumberMessage: "",
            dropdownTextStyle: TextStyles.font14blackRreg.copyWith(
              color: isDark
                  ? AppColorsDark.appTextColor
                  : AppColorsLight.appTextColor,
            ),
            style: TextStyles.font14blackRreg.copyWith(
              color: isDark
                  ? AppColorsDark.appTextColor
                  : AppColorsLight.appTextColor,
            ),
            // LocaleKeys.auth_enter_correct_phone_number.tr(),

            // initialCountryCode: 'SA',
            // controller: displayedPhoneController,
            decoration: InputDecoration(
              filled: true,
              fillColor: isDark
                  ? AppColorsDark.appSecondBgColor
                  : AppColorsLight.lightGrayColor,
              suffixIcon: widget.showContactIcon
                  ? IconButton(
                      icon: const Icon(
                        Icons.perm_contact_cal_outlined,
                        color: AppColorsLight.mainColor,
                      ),
                      onPressed: pickContact,
                    )
                  : null,

              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(
                  color: isDark
                      ? AppColorsDark.appSecondBgColor
                      : AppColorsLight.lightGrayColor,
                  // width: 2,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(color: AppColorsLight.mainColor),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(
                  color: AppColorsLight.mainAccentColor,
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(
                  color: AppColorsLight.mainAccentColor,
                ),
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 10.w,
                vertical: 14.h,
              ),
            ),
            languageCode: context.locale.languageCode,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
            ],
            onChanged: (phone) {
              widget.controller!.text = phone.completeNumber;
              widget.controller!.text = removePlusFromPhone(
                widget.controller!.text,
              );
            },
          ),
        ],
      ),
    );
  }

  String _normalizePhoneNumber(String phone) {
    phone = phone.replaceAll(RegExp(r'[^0-9+]'), '');
    if (phone.startsWith('00')) {
      phone = phone.replaceFirst('00', '+');
    }
    if (!phone.startsWith('+') && phone.length > 9) {
      phone = '+$phone';
    }
    return phone;
  }

  Map<String, String> parsePhone(String phone) {
    if (phone.isEmpty) return {'countryCode': 'SA', 'number': ''};

    String normalized = phone.trim();
    if (!normalized.startsWith('+')) {
      normalized = '+$normalized';
    }

    for (final country in countries) {
      final dialCode = '+${country.dialCode}';
      if (normalized.startsWith(dialCode)) {
        final number = normalized.substring(dialCode.length).trim();
        return {'countryCode': country.code, 'number': number};
      }
    }

    return {'countryCode': 'SA', 'number': normalized.replaceAll('+', '')};
  }
}
