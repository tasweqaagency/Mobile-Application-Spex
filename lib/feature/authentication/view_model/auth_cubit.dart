import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spex/feature/authentication/model/user_model.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitialState());

  void authenticateUser(User user) {
    emit(AuthLoadedState(user));
  }

  void logout() {
    emit(AuthInitialState());
  }
}
