import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spex/core/helpers/colors/dark_colors.dart';
import 'package:spex/core/helpers/constants/constants.dart';
import 'package:spex/core/helpers/extentions/extentions.dart';
import 'package:spex/core/routing/routing.dart';
import 'package:spex/core/widgets/app_button.dart';
import 'package:spex/core/widgets/app_text_form_field.dart';
import 'package:spex/core/widgets/snakbar.dart';
import 'package:spex/core/widgets/text_in_app_widget.dart';
import 'package:spex/feature/authentication/view_model/register_cubit/register_cubit.dart';
import 'package:spex/feature/authentication/view_model/register_cubit/register_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:spex/generated/locale_keys.g.dart';
import 'package:spex/core/helpers/colors/light_colors.dart';
import 'package:spex/feature/authentication/presentation/widgets/email_text_field.dart';
import 'package:spex/feature/authentication/presentation/widgets/password_text_field.dart';
import 'package:spex/main.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late GlobalKey<FormState> _formKey;
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _passwordController;
  late TextEditingController _confirmPasswordController;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _phoneController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state is RegisterErrorState) {
          AppSnackBar.showError(state.errorMessage);
        } else if (state is RegisterSuccessState) {
          AppSnackBar.showSuccess(LocaleKeys.auth_register_success.tr());
          context.pushReplacementNamed(Routes.loginScreen);
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: IconButton(
                        icon: Icon(
                          Icons.arrow_back_ios_new_outlined,
                          color: isDark ? AppColorsDark.appTextColor : AppColorsLight.appTextColor,
                        ),
                        onPressed: () => context.pop(),
                      ),
                    ),
                    Image.asset(
                      AppImages.appLogoImagePath,
                      width: 100,
                      height: 100,
                      color: isDark ? AppColorsLight.mainColor : null,
                      fit: BoxFit.contain,
                    ),
                    // SizedBox(height: 24.h),
                    TextInAppWidget(
                      text: LocaleKeys.auth_register_title.tr(),
                      textSize: 24,
                      fontWeightIndex: FontSelectionData.boldFontFamily,
                      textColor: isDark ? AppColorsDark.appTextColor : AppColorsLight.appTextColor,
                    ),
                    SizedBox(height: 8),
                    TextInAppWidget(
                      text: LocaleKeys.auth_register_subtitle.tr(),
                      textSize: 14,
                      textColor: Colors.grey,
                    ),
                    SizedBox(height: 32),
                    NameTextField(
                      controller: _nameController,
                      aboveText: LocaleKeys.auth_full_name.tr(),
                    ),
                    SizedBox(height: 16),
                    EmailTextField(controller: _emailController),
                    SizedBox(height: 16),
                    PhoneTextField(controller: _phoneController),
                    SizedBox(height: 16),
                    PasswordTextField(controller: _passwordController),
                    SizedBox(height: 16),
                    PasswordTextField(
                      controller: _confirmPasswordController,
                      aboveText: LocaleKeys.auth_confirm_password.tr(),
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return LocaleKeys.auth_confirm_password_required.tr();
                        }
                        if (val != _passwordController.text) {
                          return LocaleKeys.auth_passwords_do_not_match.tr();
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 32),
                    BlocBuilder<RegisterCubit, RegisterState>(
                      builder: (context, state) {
                        if (state is RegisterLoadingState) {
                          return const Center(
                            child: CircularProgressIndicator(
                              color: AppColorsLight.mainColor,
                            ),
                          );
                        }
                        return AppTextButton(
                          buttonText: LocaleKeys.auth_register.tr(),
                          textStyle: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              context.read<RegisterCubit>().register(
                                _nameController.text,
                                _emailController.text,
                                _phoneController.text,
                                _passwordController.text,
                              );
                            }
                          },
                        );
                      },
                    ),
                    SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextInAppWidget(
                          text: LocaleKeys.auth_already_have_account.tr(),
                          textSize: 14,
                          textColor:isDark ? AppColorsDark.appTextColor : AppColorsLight.appTextColor,
                        ),
                        TextButton(
                          onPressed: () =>
                              context.pushReplacementNamed(Routes.loginScreen),
                          child: TextInAppWidget(
                            text: LocaleKeys.auth_login.tr(),
                            textSize: 14,
                            textColor: Theme.of(context).primaryColor,
                            fontWeightIndex:
                                FontSelectionData.semiBoldFontFamily,
                          ),
                        ),
                      ],
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
