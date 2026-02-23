import 'package:flutter_bloc/flutter_bloc.dart';
import 'change_password_state.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  ChangePasswordCubit() : super(ChangePasswordInitialState());

  Future<void> changePassword(String newPassword) async {
    emit(ChangePasswordLoadingState());

    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));

    try {
      emit(ChangePasswordSuccessState());
    } catch (e) {
      emit(ChangePasswordErrorState(e.toString()));
    }
  }
}
