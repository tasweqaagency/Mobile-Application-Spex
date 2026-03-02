import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spex/core/di/sl.dart';
import 'package:spex/core/networking/remote_services.dart';
import 'product_details_state.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  ProductDetailsCubit() : super(ProductDetailsInitialState());

  Future<void> getProductDetails(String sku) async {
    emit(ProductDetailsLoadingState());
    try {
      final result = await getIt<RemoteServices>().getProductDetails(sku);
      result.fold(
        (failure) {
          emit(ProductDetailsErrorState(failure));
        },
        (product) {
          emit(ProductDetailsLoadedState(product));
        },
      );
    } catch (e) {
      emit(ProductDetailsErrorState(e.toString()));
    }
  }
}
