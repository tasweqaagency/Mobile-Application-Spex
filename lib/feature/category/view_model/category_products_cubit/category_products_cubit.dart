import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spex/core/di/sl.dart';
import 'package:spex/core/networking/remote_services.dart';
import 'category_products_state.dart';

class CategoryProductsCubit extends Cubit<CategoryProductsState> {
  CategoryProductsCubit() : super(CategoryProductsInitialState());

  Future<void> getCategoryProducts(
    int categoryId, {
    int page = 1,
  }) async {
    emit(CategoryProductsLoadingState());
    // try {
      final result = await getIt<RemoteServices>().getCategoryProducts(
        categoryId,
        page: page,
      );
      result.fold(
        (failure) {
          emit(CategoryProductsErrorState(failure));
        },
        (products) {
          emit(CategoryProductsLoadedState(products));
        },
      );
    // } catch (e) {
    //   emit(CategoryProductsErrorState(e.toString()));
    // }
  }
}
