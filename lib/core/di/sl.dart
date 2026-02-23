import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:spex/feature/authentication/view_model/auth_cubit.dart';
import 'package:spex/feature/layout/view_model/layout_cubit/layout_cubit.dart';
import 'package:spex/core/helpers/themes/theme_cubit.dart';

import '../helpers/constants/constants.dart';
import '../networking/local_cervices.dart';
import '../networking/web_services.dart';
import '../routing/routing.dart';

final getIt = GetIt.instance;

Future<void> setupGetIt() async {
  final dio = Dio(
    BaseOptions(
      baseUrl: ServicesConstants.baseURL,
      receiveDataWhenStatusError: true,
      connectTimeout: const Duration(seconds: 1000 * 20),
      receiveTimeout: const Duration(seconds: 1000 * 20),
      headers: {
        'Content-Type': 'application/json',
        'Access-Control-Allow-Origin': '*',
        'Access-Control-Allow-Headers': 'X-Requested-With',
      },
    ),
  );

  getIt.registerLazySingleton<LayoutCubit>(() => LayoutCubit());
  getIt.registerLazySingleton<AuthCubit>(() => AuthCubit());

  getIt.registerLazySingleton<WebServices>(() => WebServices());

  getIt.registerLazySingleton<AppRouter>(() => AppRouter());

  getIt.registerLazySingleton<LocalServices>(() => LocalServices());
  getIt.registerFactoryParam<ThemeCubit, ThemeMode, void>(
    (mode, _) => ThemeCubit(getIt<LocalServices>(), mode as ThemeMode),
  );
}
