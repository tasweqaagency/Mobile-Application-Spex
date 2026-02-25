import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spex/core/networking/remote_services.dart';
import 'package:spex/feature/search/model/search_item_model.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final RemoteServices _remoteServices;
  Timer? _debounce;

  SearchCubit(this._remoteServices) : super(SearchInitialState());

  void search(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    if (query.trim().isEmpty) {
      emit(SearchInitialState());
      return;
    }

    _debounce = Timer(const Duration(seconds: 1), () async {
      emit(SearchLoadingState());
      final result = await _remoteServices.search(query.trim());
      result.fold(
        (error) => emit(SearchErrorState(error)),
        (searchItems) => emit(SearchSuccessState(searchItems)),
      );
    });
  }

  @override
  Future<void> close() {
    _debounce?.cancel();
    return super.close();
  }
}
