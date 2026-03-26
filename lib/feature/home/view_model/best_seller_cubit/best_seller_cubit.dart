import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spex/core/di/sl.dart';
import 'package:spex/core/networking/remote_services.dart';
import 'best_seller_state.dart';

class BestSellerCubit extends Cubit<BestSellerState> {
  BestSellerCubit() : super(BestSellerInitialState());

  Future<void> getBestSellers({int page = 1}) async {
    emit(BestSellerLoadingState());
    try {
      final result = await getIt<RemoteServices>().getBestSellers(page: page);
      result.fold(
        (failure) {
          emit(BestSellerErrorState(failure));
        },
        (products) {
          emit(BestSellerLoadedState(products));
        },
      );
    } catch (e) {
      emit(BestSellerErrorState(e.toString()));
    }
  }
}
