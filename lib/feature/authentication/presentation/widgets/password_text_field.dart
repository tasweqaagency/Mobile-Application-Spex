import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:spex/core/di/sl.dart';
import 'package:spex/core/helpers/colors/light_colors.dart';
import 'package:spex/core/helpers/constants/constants.dart';
import 'package:spex/core/helpers/extentions/extentions.dart';
import 'package:spex/core/widgets/text_in_app_widget.dart';
import 'package:spex/feature/authentication/presentation/widgets/text_form_field_widget.dart';
import 'package:spex/feature/authentication/view_model/auth_cubit.dart';

import '../../../../generated/locale_keys.g.dart';

class PasswordTextField extends StatefulWidget {
  PasswordTextField({
    super.key,
    required this.controller,
    this.validator,
    this.aboveText,
    this.borderRadius,
    this.isForgetPassword = false,
    this.forgetPasswordOnTap,
  });
  TextEditingController controller;
  FormFieldValidator<String>? validator;
  String? aboveText;
  double? borderRadius;
  bool isForgetPassword;
  void Function()? forgetPasswordOnTap;

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool obscureText = true;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.isMobile ? double.infinity : 350,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormFieldWidget(
            text: widget.aboveText ?? LocaleKeys.auth_password.tr(),
            textFormController: widget.controller,
            textSize: context.isMobile ? 12 : 14,
            isColumn: true,
            fillColor: Colors.transparent,
            borderColor: Colors.grey,
            focusBorderColor: AppColorsLight.mainColor,
            contentPadding: const EdgeInsetsDirectional.symmetric(
              horizontal: 10,
            ),
            fontWeightIndex: FontSelectionData.semiBoldFontFamily,
            validator: widget.validator ?? getIt<AuthCubit>().passwordValidator,
            isPassword: true,
            borderRadius: widget.borderRadius,
            suffixIconWidget: IconButton(
              onPressed: () {
                setState(() {
                  obscureText = !obscureText;
                });
              },
              icon: Icon(
                !obscureText ? Icons.visibility : Icons.visibility_off,
                color: AppColorsLight.mainColor,
              ),
            ),
          ),
          if (widget.isForgetPassword) ...{
            InkWell(
              onTap: widget.forgetPasswordOnTap,
              child: TextInAppWidget(
                text: LocaleKeys.auth_forgot_password.tr(),
                textSize: 14,
                fontWeightIndex: FontSelectionData.regularFontFamily,
                textColor: AppColorsLight.mainColor,
              ),
            ),
          },
        ],
      ),
    );
  }
}
