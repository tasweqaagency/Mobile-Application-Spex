import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spex/core/widgets/snakbar.dart';
import '../view_model/auth_cubit.dart';
import '../view_model/auth_state.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthErrorState) {
          AppSnackBar.showError(state.errorMessage);
        } else if (state is AuthLoadedState) {
          // AppSnackBar.showSuccess("");
          // context.pushReplacementNamed(Routes.homeScreen);
        }
      },
      child: Scaffold(
        body: Padding(padding: EdgeInsets.fromLTRB(30, 100, 30, 30)),
      ),
    );
  }
}
