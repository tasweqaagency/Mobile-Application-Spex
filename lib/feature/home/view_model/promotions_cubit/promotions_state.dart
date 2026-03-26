import 'package:spex/feature/category/model/pagination_rresponse_model.dart';
import 'package:spex/feature/product_details/model/mini_product_model.dart';

abstract class PromotionsState {}

class PromotionsInitialState extends PromotionsState {}

class PromotionsLoadingState extends PromotionsState {}

class PromotionsLoadedState extends PromotionsState {
  final PaginationResponseModel<MiniProductModel> products;
  PromotionsLoadedState(this.products);
}

class PromotionsErrorState extends PromotionsState {
  final String errorMessage;

  PromotionsErrorState(this.errorMessage);
}
