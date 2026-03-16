import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spex/core/di/sl.dart';
import 'package:spex/core/networking/remote_services.dart';
import 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitialState());

  Future<void> register(
    String name,
    String email,
    String password,
  ) async {
    emit(RegisterLoadingState());
    try {
      final result = await getIt<RemoteServices>().register(name, email, password);
      result.fold(
        (error) => emit(RegisterErrorState(error)),
        (success) => emit(RegisterSuccessState()),
      );
    } catch (e) {
      emit(RegisterErrorState(e.toString()));
    }
  }
}
