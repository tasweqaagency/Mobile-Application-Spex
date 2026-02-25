import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spex/feature/authentication/model/user_model.dart';
import 'package:spex/generated/locale_keys.g.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitialState());

  void authenticateUser(User user) {
    emit(AuthLoadedState(user));
  }

  String? nameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return LocaleKeys.auth_name_required.tr();
    }
    return null;
  }

  String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return LocaleKeys.auth_email_required.tr();
    } else if (!isValidEmail(value)) {
      return LocaleKeys.auth_enter_correct_email.tr();
    }
    return null;
  }

  String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return LocaleKeys.auth_password_required.tr();
    } else if (value.toString().length < 6) {
      return LocaleKeys.auth_weak_password.tr();
    }
    return null;
  }

  bool isValidEmail(String email) {
    final emailRegex = RegExp(
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+\.[a-zA-Z]{2,}$",
    );
    return emailRegex.hasMatch(email.trim());
  }

  void logout() {
    emit(AuthInitialState());
  }
}
