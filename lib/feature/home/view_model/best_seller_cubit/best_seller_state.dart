import 'package:spex/feature/category/model/pagination_rresponse_model.dart';
import 'package:spex/feature/home/model/product_model.dart';
import 'package:spex/feature/product_details/model/mini_product_model.dart';

abstract class BestSellerState {}

class BestSellerInitialState extends BestSellerState {}

class BestSellerLoadingState extends BestSellerState {}

class BestSellerLoadedState extends BestSellerState {
  final PaginationResponseModel<MiniProductModel> products;
  BestSellerLoadedState(this.products);
}

class BestSellerErrorState extends BestSellerState {
  final String errorMessage;

  BestSellerErrorState(this.errorMessage);
}
