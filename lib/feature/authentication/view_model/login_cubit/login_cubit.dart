import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spex/core/di/sl.dart';
import 'package:spex/core/networking/local_cervices.dart';
import 'package:spex/core/networking/remote_services.dart';
import 'package:spex/feature/authentication/view_model/auth_cubit.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitialState());

  Future<void> login(String email, String password) async {
    emit(LoginLoadingState());

    try {
      final response = await getIt<RemoteServices>().login(email, password);
      response.fold((l) => emit(LoginErrorState(l)), (r) {
        getIt<AuthCubit>().authenticateUser(r);
        getIt<LocalServices>().saveUser(r);
        emit(LoginSuccessState());
      });
    } catch (e) {
      emit(LoginErrorState(e.toString()));
    }
  }
  
}
