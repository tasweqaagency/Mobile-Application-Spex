import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spex/feature/authentication/model/user_model.dart';
import 'package:spex/feature/authentication/view_model/auth_cubit.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthCubit authCubit;
  LoginCubit(this.authCubit) : super(LoginInitialState());

  Future<void> login(String email, String password) async {
    emit(LoginLoadingState());

    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));

    try {
      final user = User(
        "1",
        "Test User",
        email,
        "token123",
        "customer",
        password,
      );

      authCubit.authenticateUser(user);
      emit(LoginSuccessState());
    } catch (e) {
      emit(LoginErrorState(e.toString()));
    }
  }
}
