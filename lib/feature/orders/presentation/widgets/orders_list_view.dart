import 'package:flutter/material.dart';
import 'package:spex/core/helpers/colors/dark_colors.dart';
import 'package:spex/core/helpers/colors/light_colors.dart';
import 'package:spex/core/helpers/extentions/extentions.dart';
import 'package:spex/core/routing/routing.dart';
import 'package:spex/core/widgets/text_in_app_widget.dart';
import 'package:spex/feature/orders/model/order_model.dart';
import 'package:spex/feature/orders/presentation/widgets/order_card.dart';
import 'package:spex/main.dart';

class OrdersListView extends StatelessWidget {
  final List<OrderModel> orders;

  const OrdersListView({super.key, required this.orders});

  @override
  Widget build(BuildContext context) {
    if (orders.isEmpty) {
      return Center(
        child: TextInAppWidget(
          text: "No orders found.",
          textSize: 16,
          textColor: isDark
              ? AppColorsDark.appSecondTextColor
              : AppColorsLight.appSecondTextColor,
        ),
      );
    }
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: orders.length,
      separatorBuilder: (context, index) => verticalSpace(16),
      itemBuilder: (context, index) {
        return OrderCard(
          order: orders[index],
          onTap: () {
            context.pushNamed(
              Routes.orderDetailsScreen,
              arguments: orders[index],
            );
          },
        );
      },
    );
  }
}
