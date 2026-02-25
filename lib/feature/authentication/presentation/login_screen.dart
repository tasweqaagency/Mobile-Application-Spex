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
import 'package:spex/feature/authentication/view_model/login_cubit/login_cubit.dart';
import 'package:spex/feature/authentication/view_model/login_cubit/login_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:spex/generated/locale_keys.g.dart';
import 'package:spex/core/helpers/colors/light_colors.dart';
import 'package:spex/core/helpers/colors/dark_colors.dart';
import 'package:spex/feature/authentication/presentation/widgets/email_text_field.dart';
import 'package:spex/feature/authentication/presentation/widgets/password_text_field.dart';
import 'package:spex/main.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late GlobalKey<FormState> _formKey;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccessState) {
          AppSnackBar.showSuccess(LocaleKeys.auth_login_success.tr());
          context.pushReplacementNamed(Routes.layoutScreen);
        } else if (state is LoginErrorState) {
          AppSnackBar.showError(state.errorMessage);
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 35),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // SizedBox(height: 40.h),
                    // Center(
                    //   child:
                    Image.asset(
                      AppImages.appLogoImagePath,
                      width: 100,
                      height: 100,
                      color: isDark ? AppColorsLight.mainColor : null,
                      fit: BoxFit.contain,
                    ),
                    // ),
                    // SizedBox(height: 24.h),
                    TextInAppWidget(
                      text: LocaleKeys.auth_login_title.tr(),
                      textSize: 24,
                      fontWeightIndex: FontSelectionData.boldFontFamily,
                      textColor: isDark ? AppColorsDark.appTextColor : AppColorsLight.appTextColor,
                    ),
                    SizedBox(height: 8),
                    TextInAppWidget(
                      text: LocaleKeys.auth_login_subtitle.tr(),
                      textSize: 14,
                      textColor: Colors.grey,
                    ),
                    SizedBox(height: 32),
                    EmailTextField(controller: _emailController),
                    SizedBox(height: 16),
                    PasswordTextField(
                      controller: _passwordController,
                      isForgetPassword: true,
                      forgetPasswordOnTap: () =>
                          context.pushNamed(Routes.forgetPasswordScreen),
                    ),
                    SizedBox(height: 32),
                    BlocBuilder<LoginCubit, LoginState>(
                      builder: (context, state) {
                        if (state is LoginLoadingState) {
                          return const Center(
                            child: CircularProgressIndicator(
                              color: AppColorsLight.mainColor,
                            ),
                          );
                        }
                        return AppTextButton(
                          buttonText: LocaleKeys.auth_login.tr(),
                          textStyle: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              context.read<LoginCubit>().login(
                                _emailController.text,
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
                          text: LocaleKeys.auth_dont_have_account.tr(),
                          textSize: 14,
                          textColor: isDark ? AppColorsDark.appTextColor : AppColorsLight.appTextColor,
                        ),
                        TextButton(
                          onPressed: () => context.pushNamed(
                            Routes.registerScreen,
                          ),
                          child: TextInAppWidget(
                            text: LocaleKeys.auth_register.tr(),
                            textSize: 14,
                            textColor: Theme.of(context).primaryColor,
                            // fontWeightIndex:
                        ),
                        )
                      ],
                    ),
                    SizedBox(height: 16),
                    TextButton(
                      onPressed: () => context.pushReplacementNamed(
                        Routes.layoutScreen,
                      ),
                      child: TextInAppWidget(
                        text: LocaleKeys.auth_continue_as_guest.tr(),
                        textSize: 16,
                        textColor:AppColorsLight.mainColor,
                        fontWeightIndex: FontSelectionData.boldFontFamily,
                      ),
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
