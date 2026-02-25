import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spex/core/helpers/colors/dark_colors.dart';
import 'package:spex/core/helpers/colors/light_colors.dart';
import 'package:spex/core/helpers/constants/constants.dart';
import 'package:spex/core/helpers/extentions/extentions.dart';
import 'package:spex/core/routing/routing.dart';
import 'package:spex/core/widgets/app_button.dart';
import 'package:spex/core/widgets/app_text_form_field.dart';
import 'package:spex/core/widgets/snakbar.dart';
import 'package:spex/core/widgets/text_in_app_widget.dart';
import 'package:spex/feature/authentication/view_model/otp_cubit/otp_cubit.dart';
import 'package:spex/feature/authentication/view_model/otp_cubit/otp_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:spex/generated/locale_keys.g.dart';
import 'package:spex/core/helpers/colors/light_colors.dart';
import 'package:flutter/services.dart';
import 'package:spex/feature/authentication/presentation/widgets/email_text_field.dart';
import 'package:spex/main.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  late GlobalKey<FormState> _formKey;
  late TextEditingController _otpController;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    _otpController = TextEditingController();
  }

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<OtpCubit, OtpState>(
      listener: (context, state) {
        if (state is OtpErrorState) {
          AppSnackBar.showError(state.errorMessage);
        } else if (state is OtpSuccessState) {
          AppSnackBar.showSuccess(LocaleKeys.auth_otp_verified_success.tr());
          context.pushReplacementNamed(Routes.changePasswordScreen);
        } else if (state is OtpResendErrorState) {
          AppSnackBar.showError(state.errorMessage);
        } else if (state is OtpResendSuccessState) {
          AppSnackBar.showSuccess(LocaleKeys.auth_otp_resent_success.tr());
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
                      text: LocaleKeys.auth_verification.tr(),
                      textSize: 24.sp,
                      fontWeightIndex: FontSelectionData.boldFontFamily,
                      textColor: isDark ? AppColorsDark.appTextColor : AppColorsLight.appTextColor,
                    ),
                    SizedBox(height: 8.h),
                    TextInAppWidget(
                      text: LocaleKeys.auth_verification_subtitle.tr(),
                      textSize: 14.sp,
                      textColor: Colors.grey,
                    ),
                    SizedBox(height: 32.h),
                    GeneralTextField(
                      controller: _otpController,
                      aboveText: LocaleKeys.auth_otp_code.tr(),
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      validator: (val) => val == null || val.isEmpty
                          ? LocaleKeys.auth_otp_required.tr()
                          : null,
                    ),
                    SizedBox(height: 48.h),
                    BlocBuilder<OtpCubit, OtpState>(
                      builder: (context, state) {
                        if (state is OtpLoadingState) {
                          return const Center(
                            child: CircularProgressIndicator(
                              color: AppColorsLight.mainColor,
                            ),
                          );
                        }
                        return AppTextButton(
                          buttonText: LocaleKeys.auth_verify.tr(),
                          textStyle: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              context.read<OtpCubit>().verifyOtp(
                                _otpController.text,
                              );
                            }
                          },
                        );
                      },
                    ),
                    SizedBox(height: 24.h),
                    BlocBuilder<OtpCubit, OtpState>(
                      builder: (context, state) {
                        final remainingSeconds = context
                            .read<OtpCubit>()
                            .remainingSeconds;
                        return Column(
                          children: [
                            if (remainingSeconds > 0)
                              Center(
                                child: TextInAppWidget(
                                  text:
                                      "${LocaleKeys.auth_resend_code_in.tr()} ${remainingSeconds.toString().padLeft(2, '0')}",
                                  textSize: 14.sp,
                                  textColor: Colors.grey,
                                ),
                              )
                            else if (state is OtpResendLoadingState)
                              const Center(
                                child: CircularProgressIndicator(
                                  color: AppColorsLight.mainColor,
                                ),
                              )
                            else
                              Center(
                                child: TextButton(
                                  onPressed: () {
                                    context.read<OtpCubit>().resendOtp(
                                      "phone_mock",
                                    );
                                  },
                                  child: TextInAppWidget(
                                    text: LocaleKeys.auth_resend_code.tr(),
                                    textSize: 14.sp,
                                    textColor: Theme.of(context).primaryColor,
                                    fontWeightIndex:
                                        FontSelectionData.semiBoldFontFamily,
                                  ),
                                ),
                              ),
                          ],
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
