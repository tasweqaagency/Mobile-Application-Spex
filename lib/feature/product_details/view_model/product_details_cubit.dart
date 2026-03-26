import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spex/core/di/sl.dart';
import 'package:spex/core/helpers/extentions/extentions.dart';
import 'package:spex/core/networking/remote_services.dart';
import 'package:spex/feature/home/model/product_model.dart';
import 'package:spex/feature/product_details/model/mini_product_model.dart';
import 'product_details_state.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  ProductDetailsCubit() : super(ProductDetailsInitialState());

  void initializeProduct(SimplifiedProductModel product) {
    if (state is! ProductDetailsLoadedState) {
      emit(ProductDetailsLoadedState(product: product));
    }
  }

  Future<void> getProductDetails(String sku) async {
    // Save current selection state if we already have it
    Color? currentSelectedColor;
    String? currentSelectedSize;
    if (state is ProductDetailsLoadedState) {
      final currentState = state as ProductDetailsLoadedState;
      currentSelectedColor = currentState.selectedColor;
      currentSelectedSize = currentState.selectedSize;
    }

    if (state is ProductDetailsLoadedState) {
      if (!isClosed) {
        emit((state as ProductDetailsLoadedState).copyWith(isRefreshing: true));
      }
    } else {
      if (!isClosed) emit(ProductDetailsLoadingState());
    }

    try {
      final result = await getIt<RemoteServices>().getProductDetails(sku);

      await result.fold(
        (failure) async {
          if (!isClosed) emit(ProductDetailsErrorState(failure));
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
                res.fold((_) => null, (list) => giftProducts = list);
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

          if (!isClosed) {
            final variation = _findMatchedVariation(
              product,
              currentSelectedColor,
              currentSelectedSize,
            );
            emit(ProductDetailsLoadedState(
              product: product,
              selectedColor: currentSelectedColor,
              selectedSize: currentSelectedSize,
              matchedVariation: variation,
              isRefreshing: futures.isNotEmpty,
            ));
          }

          if (futures.isNotEmpty) {
            await Future.wait(futures);
          }

          if (!isClosed && state is ProductDetailsLoadedState) {
            emit((state as ProductDetailsLoadedState).copyWith(
              giftProducts: giftProducts,
              fbtProducts: fbtProducts,
              relatedProducts: relatedProducts,
              isRefreshing: false,
            ));
          }
        },
      );
    } catch (e) {
      if (!isClosed) emit(ProductDetailsErrorState(e.toString()));
    }
  }

  void selectColor(Color color) {
    if (state is ProductDetailsLoadedState) {
      final currentState = state as ProductDetailsLoadedState;
      final variation = _findMatchedVariation(
          currentState.product, color, currentState.selectedSize);

      emit(currentState.copyWith(
        selectedColor: color,
        matchedVariation: variation,
      ));
    }
  }

  void selectSize(String size) {
    if (state is ProductDetailsLoadedState) {
      final currentState = state as ProductDetailsLoadedState;
      final variation = _findMatchedVariation(
          currentState.product, currentState.selectedColor, size);

      emit(currentState.copyWith(
        selectedSize: size,
        matchedVariation: variation,
      ));
    }
  }

  Variations? _findMatchedVariation(
    SimplifiedProductModel product,
    Color? selectedColor,
    String? selectedSize,
  ) {
    if (product.variations == null) return null;

    for (var v in product.variations!) {
      bool colorMatch = true;
      bool sizeMatch = true;

      if (selectedColor != null) {
        String? hex = v.attributes?.paColor?.hex;
        if (hex != null) {
          colorMatch = hex.toColor() == selectedColor;
        } else {
          colorMatch = false;
        }
      }

      if (selectedSize != null) {
        sizeMatch = v.attributes?.paSize?.label == selectedSize;
      }

      if (colorMatch && sizeMatch) {
        return v;
      }
    }
    return null;
  }
}
