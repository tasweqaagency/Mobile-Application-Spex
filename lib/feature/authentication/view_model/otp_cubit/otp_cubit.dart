import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'otp_state.dart';

class OtpCubit extends Cubit<OtpState> {
  Timer? _timer;
  int countdownTime = 60;
  int remainingSeconds = 60;

  OtpCubit() : super(OtpInitialState());

  void startTimer() {
    remainingSeconds = countdownTime;
    emit(OtpTimerUpdateState(remainingSeconds));
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingSeconds > 0) {
        remainingSeconds--;
        emit(OtpTimerUpdateState(remainingSeconds));
      } else {
        _timer?.cancel();
      }
    });
  }

  Future<void> resendOtp(String phone) async {
    _timer?.cancel();
    emit(OtpResendLoadingState());

    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));

    try {
      emit(OtpResendSuccessState());
      startTimer();
    } catch (e) {
      emit(OtpResendErrorState(e.toString()));
      startTimer(); // optionally restart anyway or leave it at 0
    }
  }

  Future<void> verifyOtp(String otp) async {
    emit(OtpLoadingState());

    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));

    try {
      _timer?.cancel();
      emit(OtpSuccessState());
    } catch (e) {
      emit(OtpErrorState(e.toString()));
    }
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
