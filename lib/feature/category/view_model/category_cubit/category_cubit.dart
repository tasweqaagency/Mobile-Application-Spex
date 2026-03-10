import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spex/core/di/sl.dart';
import 'package:spex/core/networking/remote_services.dart';
import 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit() : super(CategoryInitialState());

  Future<void> getCategories() async {
    emit(CategoryLoadingState());
    try {
      final result = await getIt<RemoteServices>().getCategories();
      result.fold(
        (failure) {
          emit(CategoryErrorState(failure));
        },
        (categories) {
          emit(CategoryLoadedState(categories));
        },
      );
    } catch (e) {
      emit(CategoryErrorState(e.toString()));
    }
  }
}
