import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spex/feature/authentication/view_model/auth_cubit.dart';
import 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final AuthCubit authCubit;
  RegisterCubit(this.authCubit) : super(RegisterInitialState());

  Future<void> register(String name, String phone, String password) async {
    emit(RegisterLoadingState());

    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));

    try {
      // Logic could authenticate directly or send to login screen.
      emit(RegisterSuccessState());
    } catch (e) {
      emit(RegisterErrorState(e.toString()));
    }
  }
}
