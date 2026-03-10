import 'package:spex/feature/category/model/pagination_rresponse_model.dart';
import 'package:spex/feature/product_details/model/mini_product_model.dart';

abstract class CategoryProductsState {}

class CategoryProductsInitialState extends CategoryProductsState {}

class CategoryProductsLoadingState extends CategoryProductsState {}

class CategoryProductsLoadedState extends CategoryProductsState {
  PaginationResponseModel<MiniProductModel> products;
  CategoryProductsLoadedState(this.products);
}

class CategoryProductsErrorState extends CategoryProductsState {
  final String errorMessage;

  CategoryProductsErrorState(this.errorMessage);
}
