import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:spex/core/networking/network.dart';
import 'package:spex/core/networking/remote_services.dart';
import 'package:spex/feature/authentication/view_model/auth_cubit.dart';
import 'package:spex/feature/authentication/view_model/change_password_cubit/change_password_cubit.dart';
import 'package:spex/feature/authentication/view_model/forget_password_cubit/forget_password_cubit.dart';
import 'package:spex/feature/authentication/view_model/login_cubit/login_cubit.dart';
import 'package:spex/feature/authentication/view_model/otp_cubit/otp_cubit.dart';
import 'package:spex/feature/authentication/view_model/register_cubit/register_cubit.dart';
import 'package:spex/feature/home/view_model/category_cubit/category_cubit.dart';
import 'package:spex/feature/search/view_model/search_cubit/search_cubit.dart';
import 'package:spex/feature/layout/view_model/layout_cubit/layout_cubit.dart';
import 'package:spex/core/helpers/themes/theme_cubit.dart';

import '../helpers/constants/constants.dart';
import '../networking/local_cervices.dart';
import '../routing/routing.dart';

final getIt = GetIt.instance;

Future<void> setupGetIt() async {
  final String credentials =
      "${ServicesConstants.consumerKey}:${ServicesConstants.consumerSecret}";
  final String encoded = base64Encode(utf8.encode(credentials));

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
        'Authorization': 'Basic $encoded',
      },
    ),
  );

  getIt.registerLazySingleton<RemoteServices>(() => RemoteServices());
  getIt.registerLazySingleton<LocalServices>(() => LocalServices());
  getIt.registerLazySingleton<Network>(() => Network(dio));
  getIt.registerLazySingleton<LayoutCubit>(() => LayoutCubit());
  getIt.registerLazySingleton<AuthCubit>(() => AuthCubit());
  getIt.registerLazySingleton<AppRouter>(() => AppRouter());
  getIt.registerFactory<SearchCubit>(
    () => SearchCubit(getIt<RemoteServices>()),
  );

  getIt.registerFactoryParam<ThemeCubit, ThemeMode, void>(
    (mode, _) => ThemeCubit(getIt<LocalServices>(), mode),
  );

  getIt.registerLazySingleton<CategoryCubit>(() => CategoryCubit());

  // Auth feature specific cubits
  getIt.registerFactory<LoginCubit>(() => LoginCubit(getIt<AuthCubit>()));
  getIt.registerFactory<RegisterCubit>(() => RegisterCubit(getIt<AuthCubit>()));
  getIt.registerFactory<ForgetPasswordCubit>(() => ForgetPasswordCubit());
  getIt.registerFactory<OtpCubit>(() => OtpCubit());
  getIt.registerFactory<ChangePasswordCubit>(() => ChangePasswordCubit());
}
