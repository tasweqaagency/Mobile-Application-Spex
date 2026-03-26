import 'package:spex/feature/category/model/category_model.dart';

abstract class CategoryProductsState {}

class CategoryProductsInitialState extends CategoryProductsState {}

class CategoryProductsLoadingState extends CategoryProductsState {}

class CategoryProductsLoadedState extends CategoryProductsState {
  CategoryProduct products;
  CategoryProductsLoadedState(this.products);
}

class CategoryProductsErrorState extends CategoryProductsState {
  final String errorMessage;

  CategoryProductsErrorState(this.errorMessage);
}
