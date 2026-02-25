import 'package:spex/feature/home/model/category_model.dart';

abstract class CategoryState {}

class CategoryInitialState extends CategoryState {}

class CategoryLoadingState extends CategoryState {}

class CategoryLoadedState extends CategoryState {
  List<CategoryModel> categories;
  CategoryLoadedState(this.categories);
}

class CategoryErrorState extends CategoryState {
  final String errorMessage;

  CategoryErrorState(this.errorMessage);
}
