import 'package:flutter/material.dart';
import 'package:spex/feature/cart/presentation/widgets/coupon_section.dart';
import 'package:spex/feature/cart/presentation/widgets/delivery_address_section.dart';
import 'package:spex/feature/cart/presentation/widgets/payment_method_section.dart';
import 'package:spex/feature/cart/presentation/widgets/order_summary_section.dart';
import 'package:spex/feature/cart/presentation/widgets/checkout_bottom_button.dart';
import 'package:spex/feature/home/presentation/widgets/my_appbar.dart';
import 'package:spex/feature/cart/presentation/widgets/cart_item_widget.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBarWithLogo(),
      bottomNavigationBar: const CheckoutBottomButton(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                CartItemWidget(
                  title: 'MacBook Pro 14" M2 Max',
                  subtitle: '32GB RAM + 1TB SSD',
                  price: '2,149 EGP',
                  imageUrl:
                      'https://images.unsplash.com/photo-1517336714731-489689fd1ca8?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&q=80',
                  quantity: 1,
                  onRemove: () {},
                  onIncrement: () {},
                  onDecrement: () {},
                ),
                CouponSection(),
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
        ),
      ),
    );
  }
}
