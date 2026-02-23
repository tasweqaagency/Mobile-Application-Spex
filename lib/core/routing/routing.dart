import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spex/core/di/sl.dart';
import 'package:spex/feature/authentication/presentation/change_password_screen.dart';
import 'package:spex/feature/authentication/presentation/forget_password_screen.dart';
import 'package:spex/feature/authentication/presentation/login_screen.dart';
import 'package:spex/feature/authentication/presentation/otp_screen.dart';
import 'package:spex/feature/authentication/presentation/register_screen.dart';
import 'package:spex/feature/authentication/view_model/change_password_cubit/change_password_cubit.dart';
import 'package:spex/feature/authentication/view_model/forget_password_cubit/forget_password_cubit.dart';
import 'package:spex/feature/authentication/view_model/login_cubit/login_cubit.dart';
import 'package:spex/feature/authentication/view_model/otp_cubit/otp_cubit.dart';
import 'package:spex/feature/authentication/view_model/register_cubit/register_cubit.dart';
import 'package:spex/feature/favorite/presentation/favorite_screen.dart';
import 'package:spex/feature/notification/presentation/notification_screen.dart';
import 'package:spex/core/widgets/navigate_to_page_widget.dart';
import 'package:spex/feature/category/presentation/category_screen.dart';
import 'package:spex/feature/home/model/product_model.dart';
import 'package:spex/feature/layout/presentation/app_layout.dart';
import 'package:spex/feature/shipping_address/presentation/shipping_addresses_screen.dart';
import 'package:spex/feature/orders/model/order_model.dart';
import 'package:spex/feature/orders/presentation/my_orders_screen.dart';
import 'package:spex/feature/orders/presentation/order_details_screen.dart';
import 'package:spex/feature/product_details/presentation/product_details_screen.dart';
import 'package:spex/feature/search/presentation/search_screen.dart';

class Routes {
  static const loginScreen = '/login';
  static const registerScreen = '/register';
  static const forgetPasswordScreen = '/forgetPassword';
  static const otpScreen = '/otp';
  static const changePasswordScreen = '/changePassword';
  static const layoutScreen = '/layout';
  static const categoryScreen = '/category';
  static const productDetailsScreen = '/productDetails';
  static const searchScreen = '/search';
  static const myOrdersScreen = '/myOrders';
  static const orderDetailsScreen = '/orderDetails';
  static const shippingAddressesScreen = '/shippingAddresses';
  static const notificationScreen = '/notification';
  static const favoriteScreen = '/favorite';
}

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    //this arguments to be passed in any screen like this ( arguments as ClassName )
    final arguments = settings.arguments;

    switch (settings.name) {
      case Routes.loginScreen:
        return NavigateToPageWidget(
          BlocProvider(
            create: (_) => getIt<LoginCubit>(),
            child: const LoginScreen(),
          ),
        );
      case Routes.registerScreen:
        return NavigateToPageWidget(
          BlocProvider(
            create: (_) => getIt<RegisterCubit>(),
            child: const RegisterScreen(),
          ),
        );
      case Routes.forgetPasswordScreen:
        return NavigateToPageWidget(
          BlocProvider(
            create: (_) => getIt<ForgetPasswordCubit>(),
            child: const ForgetPasswordScreen(),
          ),
        );
      case Routes.otpScreen:
        return NavigateToPageWidget(
          BlocProvider(
            create: (_) => getIt<OtpCubit>()..startTimer(),
            child: const OtpScreen(),
          ),
        );
      case Routes.changePasswordScreen:
        return NavigateToPageWidget(
          BlocProvider(
            create: (_) => getIt<ChangePasswordCubit>(),
            child: const ChangePasswordScreen(),
          ),
        );

      // case Routes.productsScreen:
      //   if (getIt.isRegistered<CreateOrderCubit>()) {
      //     getIt<CreateOrderCubit>().close();
      //     getIt.unregister<CreateOrderCubit>();
      //   }
      //   getIt.registerSingleton<CreateOrderCubit>(
      //     CreateOrderCubit(getIt<RemoteServices>())..getDeliverySetting(),
      //   );
      //   return MaterialPageRoute(
      //     builder: (_) => BlocProvider(
      //       create: (context) => getIt<CreateOrderCubit>(),
      //       child: ProductsScreen(arguments as String),
      //     ),
      //   );

      case Routes.categoryScreen:
        return NavigateToPageWidget(const CategoryScreen());
      case Routes.layoutScreen:
        return NavigateToPageWidget(const AppLayout());
      case Routes.productDetailsScreen:
        return NavigateToPageWidget(
          ProductDetailsScreen(product: arguments as ProductModel),
        );
      case Routes.searchScreen:
        return NavigateToPageWidget(const SearchScreen());
      case Routes.myOrdersScreen:
        return NavigateToPageWidget(const MyOrdersScreen());
      case Routes.orderDetailsScreen:
        return NavigateToPageWidget(
          OrderDetailsScreen(order: arguments as OrderModel),
        );
      case Routes.shippingAddressesScreen:
        return NavigateToPageWidget(const ShippingAddressesScreen());
      case Routes.notificationScreen:
        return NavigateToPageWidget(const NotificationScreen());
      case Routes.favoriteScreen:
        return NavigateToPageWidget(const FavoriteScreen());
      // case Routes.cartScreen:
      //   return MaterialPageRoute(
      //     builder: (_) => BlocProvider.value(
      //       value: getIt<CreateOrderCubit>(),
      //       child: const CartScreen(),
      //     ),
      //   );
      default:
        return null;
    }
  }
}
