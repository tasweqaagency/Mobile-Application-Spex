import 'package:spex/feature/home/model/product_model.dart';

abstract class PromotionsState {}

class PromotionsInitialState extends PromotionsState {}

class PromotionsLoadingState extends PromotionsState {}

class PromotionsLoadedState extends PromotionsState {
  final List<SimplifiedProductModel> products;
  PromotionsLoadedState(this.products);
}

class PromotionsErrorState extends PromotionsState {
  final String errorMessage;

  PromotionsErrorState(this.errorMessage);
}
