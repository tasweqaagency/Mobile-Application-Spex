import 'package:flutter_bloc/flutter_bloc.dart';
import 'forget_password_state.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  ForgetPasswordCubit() : super(ForgetPasswordInitialState());

  Future<void> forgetPassword(String phone) async {
    emit(ForgetPasswordLoadingState());

    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));

    try {
      emit(ForgetPasswordSuccessState());
    } catch (e) {
      emit(ForgetPasswordErrorState(e.toString()));
    }
  }
}
