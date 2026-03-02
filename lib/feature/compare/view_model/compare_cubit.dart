import 'package:flutter_bloc/flutter_bloc.dart';
import '../../home/model/product_model.dart';
import 'compare_state.dart';

class CompareCubit extends Cubit<CompareState> {
  CompareCubit() : super(CompareInitial());

  final List<SimplifiedProductModel> _products = [];

  void getComparedProducts() {
    emit(CompareLoading());
    try {
      if (state is! CompareLoaded) {
        emit(CompareLoaded(List.from(_products)));
      }
    } catch (e) {
      emit(CompareError(e.toString()));
    }
  }

  void toggleCompare(SimplifiedProductModel product) {
    if (_products.any((p) => p.id == product.id)) {
      _products.removeWhere((p) => p.id == product.id);
    } else {
      if (_products.length < 4) {
        _products.add(product);
      }
    }
    emit(CompareLoaded(List.from(_products)));
  }

  void clearAll() {
    _products.clear();
    emit(CompareLoaded(List.from(_products)));
  }

  bool isInCompare(int productId) {
    return _products.any((p) => p.id == productId);
  }
}
