
import '../model/user_model.dart';

abstract class AuthState  {
}

class AuthInitialState extends AuthState {}

class AuthLoadingState extends AuthState {}

class AuthLoadedState extends AuthState {
User user ;
AuthLoadedState(this.user);
}

class AuthErrorState extends AuthState
{
  final String errorMessage;

   AuthErrorState(this.errorMessage);
}
