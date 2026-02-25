import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spex/core/helpers/colors/dark_colors.dart';
import 'package:spex/core/helpers/extentions/extentions.dart';
import 'package:spex/core/routing/routing.dart';
import 'package:spex/core/widgets/app_button.dart';
import 'package:spex/core/widgets/app_text_form_field.dart';
import 'package:spex/core/widgets/snakbar.dart';
import 'package:spex/core/widgets/text_in_app_widget.dart';
import 'package:spex/feature/authentication/view_model/forget_password_cubit/forget_password_cubit.dart';
import 'package:spex/feature/authentication/view_model/forget_password_cubit/forget_password_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:spex/generated/locale_keys.g.dart';
import 'package:spex/core/helpers/colors/light_colors.dart';
import 'package:spex/feature/authentication/presentation/widgets/email_text_field.dart';
import 'package:spex/main.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  late GlobalKey<FormState> _formKey;
  late TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    _emailController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ForgetPasswordCubit, ForgetPasswordState>(
      listener: (context, state) {
        if (state is ForgetPasswordErrorState) {
          AppSnackBar.showError(state.errorMessage);
        } else if (state is ForgetPasswordSuccessState) {
          AppSnackBar.showSuccess(LocaleKeys.auth_otp_sent_success.tr());
          context.pushNamed(Routes.otpScreen);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_new_outlined,
              color: isDark ? AppColorsDark.appTextColor : AppColorsLight.appTextColor,
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
                      text: LocaleKeys.auth_forget_password_title.tr(),
                      textSize: 24.sp,
                      fontWeightIndex: 700,
                      textColor: isDark ? AppColorsDark.appTextColor : AppColorsLight.appTextColor,
                    ),
                    SizedBox(height: 8.h),
                    TextInAppWidget(
                      text: LocaleKeys.auth_forget_password_subtitle.tr(),
                      textSize: 14.sp,
                      textColor: Colors.grey,
                    ),
                    SizedBox(height: 32.h),
                    EmailTextField(controller: _emailController),
                    SizedBox(height: 48.h),
                    BlocBuilder<ForgetPasswordCubit, ForgetPasswordState>(
                      builder: (context, state) {
                        if (state is ForgetPasswordLoadingState) {
                          return const Center(
                            child: CircularProgressIndicator(
                              color: AppColorsLight.mainColor,
                            ),
                          );
                        }
                        return AppTextButton(
                          buttonText: LocaleKeys.auth_send_otp.tr(),
                          textStyle: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              context
                                  .read<ForgetPasswordCubit>()
                                  .forgetPassword(_emailController.text);
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
