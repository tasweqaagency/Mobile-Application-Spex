part of 'search_cubit.dart';

abstract class SearchState {}

class SearchInitialState extends SearchState {}

class SearchLoadingState extends SearchState {}

class SearchSuccessState extends SearchState {
  final List<MiniProductModel> searchItems;
  SearchSuccessState(this.searchItems);
}

class SearchErrorState extends SearchState {
  final String errorMessage;
  SearchErrorState(this.errorMessage);
}
