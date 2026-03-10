import 'package:spex/feature/home/model/product_model.dart';

abstract class ProductDetailsState {}

class ProductDetailsInitialState extends ProductDetailsState {}

class ProductDetailsLoadingState extends ProductDetailsState {}

class ProductDetailsLoadedState extends ProductDetailsState {
  final SimplifiedProductModel product;
  final List<SimplifiedProductModel> giftProducts;
  final List<SimplifiedProductModel> fbtProducts;
  final List<SimplifiedProductModel> relatedProducts;

  ProductDetailsLoadedState({
    required this.product,
    this.giftProducts = const [],
    this.fbtProducts = const [],
    this.relatedProducts = const [],
  });
}

class ProductDetailsErrorState extends ProductDetailsState {
  final String errorMessage;

  ProductDetailsErrorState(this.errorMessage);
}
