import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:spex/feature/cart/presentation/cart_screen.dart';
import 'package:spex/feature/category/presentation/category_screen.dart';
import 'package:spex/feature/profile/presentation/profile_screen.dart';
import 'package:spex/feature/promosion/presentation/promosion_screen.dart';

import '../../../home/presentation/home_screen.dart';

class LayoutCubit extends Cubit<int> {
  LayoutCubit() : super(0);
  // List<Widget> pages = [
  //   HomeScreen(),
  //   const MapScreen(),
  //   const MyOrdersScreen(),
  //   const QrCodeScreen(),
  //   //BarcodePage(),
  //   const ProfileScreen(),
  // ];
  //
  // void changeIndex(int index) => emit(index);

  void reset() => emit(0);
  final List<Widget?> _screens = List.generate(5, (_) => null);

  Widget getScreen(int index) {
    _screens[index] ??= _createScreen(index);
    return _screens[index]!;
  }

  Widget _createScreen(int index) {
    switch (index) {
      case 0:
        return const HomeScreen();
      case 1:
        return const CategoryScreen();
      case 2:
        return const PromosionScreen();
      case 3:
        return const CartScreen();
      case 4:
        return const ProfileScreen();
      default:
        return const HomeScreen();
    }
  }

  void changeIndex(int index) => emit(index);
}
