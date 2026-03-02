import 'package:spex/feature/home/model/product_model.dart';

abstract class BestSellerState {}

class BestSellerInitialState extends BestSellerState {}

class BestSellerLoadingState extends BestSellerState {}

class BestSellerLoadedState extends BestSellerState {
  final List<SimplifiedProductModel> products;
  BestSellerLoadedState(this.products);
}

class BestSellerErrorState extends BestSellerState {
  final String errorMessage;

  BestSellerErrorState(this.errorMessage);
}
