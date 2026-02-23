import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spex/core/networking/local_cervices.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  final LocalServices _localServices;

  ThemeCubit(this._localServices, ThemeMode initialState) : super(initialState);

  void getSavedTheme() async {
    final bool isDark = await _localServices.getTheme();
    emit(isDark ? ThemeMode.dark : ThemeMode.light);
  }

  void changeTheme(bool isDark) async {
    await _localServices.saveTheme(isDark);
    emit(isDark ? ThemeMode.dark : ThemeMode.light);
  }
}
