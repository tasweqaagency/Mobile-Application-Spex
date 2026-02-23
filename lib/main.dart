import 'package:device_preview/device_preview.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:spex/core/helpers/themes/dark_theme_data.dart';
import 'package:spex/core/helpers/themes/light_theme_data.dart';
import 'package:spex/core/helpers/themes/theme_cubit.dart';
import 'package:spex/feature/layout/view_model/layout_cubit/layout_cubit.dart';
import 'bloc_observer.dart';
import 'core/di/sl.dart';
import 'core/helpers/constants/constants.dart';
import 'core/networking/local_cervices.dart';
import 'core/routing/routing.dart';
import 'feature/authentication/model/user_model.dart';
import 'feature/authentication/view_model/auth_cubit.dart';

bool isOnBoarding = false;
bool isDark = false;
final GlobalKey<ScaffoldMessengerState> snackbarKey =
    GlobalKey<ScaffoldMessengerState>();
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<ScaffoldMessengerState> snackBarKey =
    GlobalKey<ScaffoldMessengerState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await setupGetIt();
  Bloc.observer = AppBlocObserver();
  await Hive.initFlutter();
  await EasyLocalization.ensureInitialized();
  Hive.registerAdapter(UserAdapter());

  final isAuthenticated = true;
  // await getIt<AuthCubit>().isUserAuthenticable();
  final bool isOnBoardingSeen = await getIt<LocalServices>().getOnBoarding();
  isOnBoarding = isOnBoardingSeen;
  final bool isDarkTheme = await getIt<LocalServices>().getTheme();
  isDark = isDarkTheme;
  runApp(
    DevicePreview(
      builder: (context) => EasyLocalization(
        supportedLocales: [const Locale('en'), const Locale('ar')],
        path: 'assets/translations',
        fallbackLocale: const Locale('ar'),
        child: Spex(
          isUserAuthenticable: isAuthenticated,
          isOnBoardingSeen: isOnBoarding,
          isDarkTheme: isDark,
        ),
      ),

      enabled: !kReleaseMode,
    ),
  );
}

class Spex extends StatelessWidget {
  final bool isUserAuthenticable;
  final bool isOnBoardingSeen;
  final bool isDarkTheme;

  const Spex({
    super.key,
    required this.isUserAuthenticable,
    required this.isOnBoardingSeen,
    required this.isDarkTheme,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
          lazy: false,
          create: (context) => getIt<AuthCubit>(),
        ),
        BlocProvider<LayoutCubit>(
          lazy: false,
          create: (context) => getIt<LayoutCubit>(),
        ),
        BlocProvider<ThemeCubit>(
          create: (context) => getIt<ThemeCubit>(
            param1: isDarkTheme ? ThemeMode.dark : ThemeMode.light,
          )..getSavedTheme(),
        ),
      ],
      child: ScreenUtilInit(
        minTextAdapt: true,
        builder: (context, child) {
          return BlocBuilder<ThemeCubit, ThemeMode>(
            builder: (context, mode) {
              isDark = mode == ThemeMode.dark;
              return MaterialApp(
                // showPerformanceOverlay: true,
                themeMode: mode,
                localizationsDelegates: context.localizationDelegates,
                supportedLocales: context.supportedLocales,
                locale: context.locale,
                scaffoldMessengerKey: snackbarKey,
                navigatorKey: navigatorKey,
                debugShowCheckedModeBanner: false,
                title: AppConstants.APP_NAME,
                theme: lightThemeData(),
                darkTheme: darkThemeData(),
                initialRoute:
                    // isAuthenticated ? Routes.homeScreen :
                    Routes.layoutScreen,
                onGenerateRoute: getIt<AppRouter>().generateRoute,
              );
            },
          );
        },
      ),
    );
  }
}
