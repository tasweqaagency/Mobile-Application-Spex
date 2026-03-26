import 'package:flutter/material.dart';
import 'package:spex/core/helpers/colors/dark_colors.dart';
import 'package:spex/core/helpers/colors/light_colors.dart';
import 'package:spex/feature/cart/presentation/widgets/coupon_section.dart';
import 'package:spex/feature/cart/presentation/widgets/delivery_address_section.dart';
import 'package:spex/feature/cart/presentation/widgets/payment_method_section.dart';
import 'package:spex/feature/cart/presentation/widgets/order_summary_section.dart';
import 'package:spex/feature/cart/presentation/widgets/checkout_bottom_button.dart';
import 'package:spex/feature/home/presentation/widgets/my_appbar.dart';
import 'package:spex/feature/cart/presentation/widgets/cart_item_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spex/feature/cart/view_model/cart_cubit.dart';
import 'package:spex/feature/cart/view_model/cart_state.dart';
import 'package:spex/generated/locale_keys.g.dart';
import 'package:spex/core/widgets/text_in_app_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:spex/feature/cart/model/cart_item.dart';
import 'package:spex/main.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        final List<CartItem> items = state is CartUpdated ? state.items : [];
        final bool isEmpty = items.isEmpty;

        return Scaffold(
          appBar: const MyAppBarWithLogo(),
          bottomNavigationBar: isEmpty ? null : const CheckoutBottomButton(),
          body: SafeArea(
            child: isEmpty ? const EmptyCartWidget() : CartContentWidget(items: items),
          ),
        );
      },
    );
  }
}

class EmptyCartWidget extends StatelessWidget {
  const EmptyCartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.shopping_cart_outlined, size: 80, color: Colors.grey),
          const SizedBox(height: 16),
          TextInAppWidget(
            text: LocaleKeys.cart_empty_message.tr(),
            textSize: 18,
            textColor:
                isDark ? AppColorsDark.appTextColor : AppColorsLight.appTextColor,
          ),
        ],
      ),
    );
  }
}

class CartContentWidget extends StatelessWidget {
  final List<CartItem> items;
  const CartContentWidget({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ...items.map((item) => CartItemWidget(item: item)),
            const CouponSection(),
            const SizedBox(height: 16),
            const DeliveryAddressSection(),
            const SizedBox(height: 16),
            const PaymentMethodSection(),
            const SizedBox(height: 16),
            const OrderSummarySection(),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
