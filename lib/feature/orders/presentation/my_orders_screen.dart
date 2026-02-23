import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:spex/core/helpers/colors/dark_colors.dart';
import 'package:spex/core/helpers/colors/light_colors.dart';
import 'package:spex/core/helpers/constants/constants.dart';
import 'package:spex/feature/home/model/product_model.dart';
import 'package:spex/feature/home/presentation/widgets/my_appbar.dart';
import 'package:spex/feature/orders/model/order_model.dart';
import 'package:spex/feature/orders/presentation/widgets/orders_list_view.dart';
import 'package:spex/generated/locale_keys.g.dart';
import 'package:spex/main.dart';

class MyOrdersScreen extends StatefulWidget {
  const MyOrdersScreen({super.key});

  @override
  State<MyOrdersScreen> createState() => _MyOrdersScreenState();
}

class _MyOrdersScreenState extends State<MyOrdersScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<OrderModel> mockOrders = [
    OrderModel(
      id: "SPX-88291",
      date: DateTime.now().subtract(const Duration(days: 5)),
      status: OrderStatus.delivered,
      totalAmount: 1249.00,
      items: [
        OrderItemModel(
          product: ProductModel(
            id: 1,
            name: "Pro Wireless Headphones",
            category: "Electronics",
            imagePath: [AppImages.appLogoImagePath], // Placeholder
            rating: 4.5,
            price: 849.00,
            description: "",
          ),
          quantity: 1,
        ),
        OrderItemModel(
          product: ProductModel(
            id: 2,
            name: "Elite Series Watch",
            category: "Accessories",
            imagePath: [AppImages.appLogoImagePath], // Placeholder
            rating: 4.8,
            price: 400.00,
            description: "",
          ),
          quantity: 1,
        ),
        OrderItemModel(
          product: ProductModel(
            id: 1,
            name: "Pro Wireless Headphones",
            category: "Electronics",
            imagePath: [AppImages.appLogoImagePath], // Placeholder
            rating: 4.5,
            price: 849.00,
            description: "",
          ),
          quantity: 1,
        ),
        OrderItemModel(
          product: ProductModel(
            id: 2,
            name: "Elite Series Watch",
            category: "Accessories",
            imagePath: [AppImages.appLogoImagePath], // Placeholder
            rating: 4.8,
            price: 400.00,
            description: "",
          ),
          quantity: 1,
        ),
      ],
    ),
    OrderModel(
      id: "SPX-88402",
      date: DateTime.now().subtract(const Duration(days: 2)),
      status: OrderStatus.inTransit,
      totalAmount: 399.00,
      items: [
        OrderItemModel(
          product: ProductModel(
            id: 3,
            name: "Smart Speaker Mini",
            category: "Electronics",
            imagePath: [AppImages.appLogoImagePath], // Placeholder
            rating: 4.2,
            price: 399.00,
            description: "",
          ),
          quantity: 1,
        ),
      ],
    ),
    OrderModel(
      id: "SPX-87105",
      date: DateTime.now().subtract(const Duration(days: 10)),
      status: OrderStatus.delivered,
      totalAmount: 159.50,
      items: [
        OrderItemModel(
          product: ProductModel(
            id: 4,
            name: "USB-C Fast Charger",
            category: "Accessories",
            imagePath: [AppImages.appLogoImagePath], // Placeholder
            rating: 4.0,
            price: 79.75,
            description: "",
          ),
          quantity: 2,
        ),
      ],
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: mockOrders.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List<OrderModel> getFilteredOrders(int index) {
    if (index == 0) return mockOrders;
    if (index == 1) {
      return mockOrders
          .where(
            (o) =>
                o.status == OrderStatus.inTransit ||
                o.status == OrderStatus.processed ||
                o.status == OrderStatus.orderPlaced,
          )
          .toList();
    }
    if (index == 2) {
      return mockOrders
          .where((o) => o.status == OrderStatus.delivered)
          .toList();
    }
    return [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isDark
          ? AppColorsDark.appBgColor
          : AppColorsLight.appBgColor,
      appBar: MyAppBarWithBackButton(
        title: LocaleKeys.orders_order_history.tr(),
        showSearch: false,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            // margin: EdgeInsets.symmetric(horizontal: 16),
            child: TabBar(
              controller: _tabController,
              isScrollable: true,
              dividerColor: Colors.transparent,
              indicatorSize: TabBarIndicatorSize.tab,
              enableFeedback: false,
              physics: const ClampingScrollPhysics(),
              splashBorderRadius: BorderRadius.circular(25),
              dividerHeight: 0,
              padding: EdgeInsets.symmetric(horizontal: 15),
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(25),

                color: AppColorsLight.mainColor,
              ),
              labelColor: Colors.white,
              unselectedLabelColor: isDark
                  ? AppColorsDark.appSecondTextColor
                  : AppColorsLight.appSecondTextColor,
              tabs: [
                Tab(text: LocaleKeys.orders_all_orders.tr()),
                Tab(text: LocaleKeys.orders_in_transit.tr()),
                Tab(text: LocaleKeys.orders_completed.tr()),
              ],
            ),
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          OrdersListView(orders: getFilteredOrders(0)),
          OrdersListView(orders: getFilteredOrders(1)),
          OrdersListView(orders: getFilteredOrders(2)),
        ],
      ),
    );
  }
}
