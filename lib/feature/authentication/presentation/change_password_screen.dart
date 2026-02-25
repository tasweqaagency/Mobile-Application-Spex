import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spex/core/helpers/constants/constants.dart';
import 'package:spex/core/helpers/extentions/extentions.dart';
import 'package:spex/core/routing/routing.dart';
import 'package:spex/core/widgets/app_button.dart';
import 'package:spex/core/widgets/app_text_form_field.dart';
import 'package:spex/core/widgets/snakbar.dart';
import 'package:spex/core/widgets/text_in_app_widget.dart';
import 'package:spex/feature/authentication/view_model/change_password_cubit/change_password_cubit.dart';
import 'package:spex/feature/authentication/view_model/change_password_cubit/change_password_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:spex/generated/locale_keys.g.dart';
import 'package:spex/core/helpers/colors/light_colors.dart';
import 'package:spex/feature/authentication/presentation/widgets/password_text_field.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  late GlobalKey<FormState> _formKey;
  late TextEditingController _newPasswordController;
  late TextEditingController _confirmNewPasswordController;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    _newPasswordController = TextEditingController();
    _confirmNewPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    _newPasswordController.dispose();
    _confirmNewPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ChangePasswordCubit, ChangePasswordState>(
      listener: (context, state) {
        if (state is ChangePasswordErrorState) {
          AppSnackBar.showError(state.errorMessage);
        } else if (state is ChangePasswordSuccessState) {
          AppSnackBar.showSuccess(
            LocaleKeys.auth_password_changed_success.tr(),
          );
          context.pushReplacementNamed(Routes.loginScreen);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Theme.of(context).iconTheme.color,
            ),
            onPressed: () => context.pop(),
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(24.w),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20.h),
                    TextInAppWidget(
                      text: LocaleKeys.auth_new_password_title.tr(),
                      textSize: 24.sp,
                      fontWeightIndex: FontSelectionData.boldFontFamily,
                    ),
                    SizedBox(height: 8.h),
                    TextInAppWidget(
                      text: LocaleKeys.auth_new_password_subtitle.tr(),
                      textSize: 14.sp,
                      textColor: Colors.grey,
                    ),
                    SizedBox(height: 32.h),
                    PasswordTextField(
                      controller: _newPasswordController,
                      aboveText: LocaleKeys.auth_new_password_title.tr(),
                    ),
                    SizedBox(height: 16.h),
                    PasswordTextField(
                      controller: _confirmNewPasswordController,
                      aboveText: LocaleKeys.auth_confirm_password.tr(),
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return LocaleKeys.auth_confirm_password_required.tr();
                        }
                        if (val != _newPasswordController.text) {
                          return LocaleKeys.auth_passwords_do_not_match.tr();
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 48.h),
                    BlocBuilder<ChangePasswordCubit, ChangePasswordState>(
                      builder: (context, state) {
                        if (state is ChangePasswordLoadingState) {
                          return const Center(
                            child: CircularProgressIndicator(
                              color: AppColorsLight.mainColor,
                            ),
                          );
                        }
                        return AppTextButton(
                          buttonText: LocaleKeys.auth_update_password.tr(),
                          textStyle: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              context
                                  .read<ChangePasswordCubit>()
                                  .changePassword(_newPasswordController.text);
                            }
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
