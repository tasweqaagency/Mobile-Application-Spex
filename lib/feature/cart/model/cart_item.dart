import 'package:spex/feature/product_details/model/mini_product_model.dart';

class CartItem {
  final int productId;
  final int? variationId;
  final String name;
  final String image;
  final double price;
  final String? selectedSize;
  final String? selectedColor;
  int quantity;
  final Variations? variation;

  CartItem({
    required this.productId,
    this.variationId,
    required this.name,
    required this.image,
    required this.price,
    this.selectedSize,
    this.selectedColor,
    this.quantity = 1,
    this.variation,
  });

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'variationId': variationId,
      'name': name,
      'image': image,
      'price': price,
      'selectedSize': selectedSize,
      'selectedColor': selectedColor,
      'quantity': quantity,
      'variation': variation?.toJson(),
    };
  }

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      productId: json['productId'] is String ? int.tryParse(json['productId']) ?? 0 : json['productId'] as int,
      variationId: json['variationId'] is String ? int.tryParse(json['variationId']) : json['variationId'] as int?,
      name: json['name']?.toString() ?? '',
      image: json['image']?.toString() ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      selectedSize: json['selectedSize']?.toString(),
      selectedColor: json['selectedColor']?.toString(),
      quantity: json['quantity'] as int? ?? 1,
      variation: json['variation'] != null ? Variations.fromJson(json['variation']) : null,
    );
  }

  CartItem copyWith({
    int? quantity,
  }) {
    return CartItem(
      productId: productId,
      variationId: variationId,
      name: name,
      image: image,
      price: price,
      selectedSize: selectedSize,
      selectedColor: selectedColor,
      quantity: quantity ?? this.quantity,
      variation: variation,
    );
  }
}
