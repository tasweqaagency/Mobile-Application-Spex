import 'package:spex/feature/home/model/product_model.dart';

abstract class ProductDetailsState {}

class ProductDetailsInitialState extends ProductDetailsState {}

class ProductDetailsLoadingState extends ProductDetailsState {}

class ProductDetailsLoadedState extends ProductDetailsState {
  final SimplifiedProductModel product;
  ProductDetailsLoadedState(this.product);
}

class ProductDetailsErrorState extends ProductDetailsState {
  final String errorMessage;

  ProductDetailsErrorState(this.errorMessage);
}
