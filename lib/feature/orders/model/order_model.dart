import 'package:spex/feature/home/model/product_model.dart';

enum OrderStatus { delivered, inTransit, processed, orderPlaced }

class OrderModel {
  final String id;
  final DateTime date;
  final OrderStatus status;
  final double totalAmount;
  final List<OrderItemModel> items;

  OrderModel({
    required this.id,
    required this.date,
    required this.status,
    required this.totalAmount,
    required this.items,
  });
}

class OrderItemModel {
  final ProductModel product;
  final int quantity;

  OrderItemModel({required this.product, required this.quantity});
}
