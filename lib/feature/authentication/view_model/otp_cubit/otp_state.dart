abstract class OtpState {}

class OtpInitialState extends OtpState {}

class OtpLoadingState extends OtpState {}

class OtpSuccessState extends OtpState {}

class OtpErrorState extends OtpState {
  final String errorMessage;
  OtpErrorState(this.errorMessage);
}

class OtpTimerUpdateState extends OtpState {
  final int remainingSeconds;
  OtpTimerUpdateState(this.remainingSeconds);
}

class OtpResendLoadingState extends OtpState {}

class OtpResendSuccessState extends OtpState {}

class OtpResendErrorState extends OtpState {
  final String errorMessage;
  OtpResendErrorState(this.errorMessage);
}
