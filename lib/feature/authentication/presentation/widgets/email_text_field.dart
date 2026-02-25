import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:spex/core/di/sl.dart';
import 'package:spex/core/helpers/colors/dark_colors.dart';
import 'package:spex/core/helpers/colors/light_colors.dart';
import 'package:spex/core/helpers/constants/constants.dart';

import 'dart:ui' as ui;

import 'package:spex/core/helpers/extentions/extentions.dart';
import 'package:spex/core/widgets/text_in_app_widget.dart';
import 'package:spex/feature/authentication/presentation/widgets/text_form_field_widget.dart';
import 'package:spex/feature/authentication/view_model/auth_cubit.dart';
import 'package:spex/generated/locale_keys.g.dart';
import 'package:spex/main.dart';

class EmailTextField extends StatelessWidget {
  const EmailTextField({
    super.key,
    required this.controller,
    this.validator,
    this.borderRadius,
  });
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;
  final double? borderRadius;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.isMobile ? double.infinity : 350,
      child: TextFormFieldWidget(
        isLTR: true,
        text: LocaleKeys.auth_email.tr(),
        textFormController: controller,
        textSize: context.isMobile ? 12 : 14,
        isColumn: true,
        fillColor: Colors.transparent,
        borderColor: Colors.grey,
        focusBorderColor: AppColorsLight.mainColor,
        contentPadding: const EdgeInsetsDirectional.symmetric(horizontal: 10),
        fontWeightIndex: FontSelectionData.semiBoldFontFamily,
        validator: getIt<AuthCubit>().emailValidator,
        borderRadius: borderRadius,
      ),
    );
  }
}

class NameTextField extends StatelessWidget {
  const NameTextField({
    super.key,
    required this.controller,
    this.validator,
    this.aboveText,
    this.borderRadius,
  });
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;
  final String? aboveText;
  final double? borderRadius;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.isMobile ? double.infinity : 350,
      child: TextFormFieldWidget(
        text: aboveText ?? LocaleKeys.auth_name.tr(),
        textFormController: controller,
        textSize: context.isMobile ? 12 : 14,
        isColumn: true,
        fillColor: Colors.transparent,
        borderColor: Colors.grey,
        focusBorderColor: AppColorsLight.mainColor,
        contentPadding: const EdgeInsetsDirectional.symmetric(horizontal: 10),
        fontWeightIndex: FontSelectionData.semiBoldFontFamily,
        validator: getIt<AuthCubit>().nameValidator,
        borderRadius: borderRadius,
      ),
    );
  }
}

class GeneralTextField extends StatelessWidget {
  const GeneralTextField({
    super.key,
    required this.controller,
    this.validator,
    this.aboveText,
    this.borderRadius,
    this.hint,
    this.height,
    this.width,
    this.keyboardType,
    this.inputFormatters,
  });
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;
  final String? aboveText;
  final double? borderRadius;
  final String? hint;
  final double? height;
  final double? width;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? (context.isMobile ? double.infinity : 350),
      child: TextFormFieldWidget(
        text: aboveText ?? '',
        textFormController: controller,
        textFormHeight: height,
        textSize: context.isMobile ? 12 : 14,
        isColumn: true,
        fillColor: Colors.transparent,
        borderColor: Colors.grey,
        focusBorderColor: AppColorsLight.mainColor,
        contentPadding: const EdgeInsetsDirectional.symmetric(horizontal: 10),
        fontWeightIndex: FontSelectionData.semiBoldFontFamily,
        hintText: hint,
        validator: validator,
        borderRadius: borderRadius,
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
      ),
    );
  }
}

// class PhoneTextField extends StatelessWidget {
//   PhoneTextField({super.key,required this.controller, this.validator});
//   TextEditingController controller ;
//   FormFieldValidator<String>? validator ;
//   @override
//   Widget build(BuildContext context) {
//     return TextFormFieldWidget(
//       isLTR: true,
//       text: LocaleKeys.auth_phone_number.tr(),
//       textFormController: controller,
//       textSize: 14,
//       isColumn: true,
//       fillColor: Colors.transparent,
//       borderColor: AppColors.mainColor.withValues(alpha: 0.5),
//       contentPadding: const EdgeInsetsDirectional.symmetric(horizontal: 10),
//       fontWeightIndex: FontSelectionData.semiBoldFontFamily,
//       validator: getIt<AuthCubit>().phoneValidator,
//       prefix: SizedBox(
//         width: 60,
//         height: 50,
//         child: Align(
//           alignment: Alignment.centerLeft,
//           child: Padding(
//             padding:  const EdgeInsets.all(10),
//             child: Text('+966 ',
//                 style: TextStyles.font14graySemiBold,
//                 textAlign: TextAlign.center),
//           ),
//         ),
//       ),
//
//     );
//   }
// }

class PhoneTextField extends StatefulWidget {
  const PhoneTextField({
    super.key,
    required this.controller,
    this.validator,
    this.aboveText,
    this.isReadOnly = false,
    this.initialCountry = 'EG',
    this.initialNumber,
    this.borderRadius,
  });
  final String? initialCountry;
  final String? initialNumber;
  final String? aboveText;
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;
  final bool isReadOnly;
  final double? borderRadius;

  @override
  State<PhoneTextField> createState() => _PhoneTextFieldState();
}

class _PhoneTextFieldState extends State<PhoneTextField> {
  // String? initialCountry;
  // String? initialNumber;
  // @override
  // void initState() {
  //   super.initState();
  //   final parsed = parsePhoneNumber(widget.controller.text);
  //   initialCountry = parsed['countryCode']!;
  //   initialNumber = parsed['number']!;
  // }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    bool isMobile = size.width <= ValuesOfAllApp.mobileWidth;

    return SizedBox(
      width: context.isMobile ? double.infinity : 350,
      child: Directionality(
        textDirection: ui.TextDirection.ltr,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: context.locale.languageCode == "en"
              ? CrossAxisAlignment.start
              : CrossAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: TextInAppWidget(
                text: widget.aboveText ?? LocaleKeys.auth_phone_number.tr(),
                textColor: isDark
                    ? AppColorsDark.appTextColor
                    : AppColorsLight.appTextColor,
                textSize: isMobile ? 12 : 14,
                fontWeightIndex: FontSelectionData.semiBoldFontFamily,
                isEllipsisTextOverflow: true,
              ),
            ),
            const SizedBox(height: 5),
            IntlPhoneField(
              key: ValueKey("${widget.initialCountry}_${widget.initialNumber}"),
              initialCountryCode: widget.initialCountry,
              initialValue: widget.initialNumber,
              readOnly: widget.isReadOnly,
              invalidNumberMessage: LocaleKeys.auth_enter_correct_phone_number
                  .tr(),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
              ],
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.transparent,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    widget.borderRadius ?? 10,
                  ),
                  borderSide: const BorderSide(color: Colors.grey, width: 1.2),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    widget.borderRadius ?? 10,
                  ),
                  borderSide: const BorderSide(color: Colors.grey, width: 1.2),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    widget.borderRadius ?? 10,
                  ),
                  borderSide: const BorderSide(
                    color: AppColorsLight.mainColor,
                    width: 1.2,
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    widget.borderRadius ?? 10,
                  ),
                  borderSide: const BorderSide(color: Colors.red, width: 1.2),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    widget.borderRadius ?? 10,
                  ),
                  borderSide: const BorderSide(color: Colors.red, width: 1.2),
                ),
                contentPadding: const EdgeInsetsDirectional.symmetric(
                  horizontal: 10,
                ),
              ),
              languageCode: context.locale.languageCode,
              onChanged: (phone) {
                widget.controller.text = phone.completeNumber;
                widget.controller.text = removePlusFromPhone(
                  widget.controller.text,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Map<String, String> parsePhoneNumber(String phone) {
    if (phone.isEmpty) return {'countryCode': 'EG', 'number': ''};

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

    return {'countryCode': 'EG', 'number': normalized.replaceAll('+', '')};
  }
}
