import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spex/core/di/sl.dart';
import 'package:spex/core/networking/remote_services.dart';
import 'package:spex/feature/home/model/product_model.dart';
import 'product_details_state.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  ProductDetailsCubit() : super(ProductDetailsInitialState());

  Future<void> getProductDetails(String sku) async {
    emit(ProductDetailsLoadingState());
    try {
      final result = await getIt<RemoteServices>().getProductDetails(sku);

      await result.fold(
        (failure) async {
          emit(ProductDetailsErrorState(failure));
        },
        (product) async {
          List<SimplifiedProductModel> giftProducts = [];
          List<SimplifiedProductModel> fbtProducts = [];
          List<SimplifiedProductModel> relatedProducts = [];

          final List<Future<void>> futures = [];

          if (product.giftProducts.isNotEmpty) {
            futures.add(
              getIt<RemoteServices>()
                  .getListOfProducts(product.giftProducts)
                  .then((res) {
                    res.fold((_) => null,
                            (list) => giftProducts = list);
                  }),
            );
          }

          if (product.fbtProducts.isNotEmpty) {
            futures.add(
              getIt<RemoteServices>()
                  .getListOfProducts(product.fbtProducts)
                  .then((res) {
                    res.fold((_) => null, (list) => fbtProducts = list);
                  }),
            );
          }

          if (product.relatedProducts.isNotEmpty) {
            futures.add(
              getIt<RemoteServices>()
                  .getListOfProducts(product.relatedProducts)
                  .then((res) {
                    res.fold((_) => null, (list) => relatedProducts = list);
                  }),
            );
          }

          if (futures.isNotEmpty) {
            await Future.wait(futures);
          }

          emit(
            ProductDetailsLoadedState(
              product: product,
              giftProducts: giftProducts,
              fbtProducts: fbtProducts,
              relatedProducts: relatedProducts,
            ),
          );
        },
      );
    } catch (e) {
      emit(ProductDetailsErrorState(e.toString()));
    }
  }
}
