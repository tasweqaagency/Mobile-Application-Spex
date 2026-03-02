import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spex/core/di/sl.dart';
import 'package:spex/core/networking/remote_services.dart';
import 'promotions_state.dart';

class PromotionsCubit extends Cubit<PromotionsState> {
  PromotionsCubit() : super(PromotionsInitialState());

  Future<void> getPromotions() async {
    emit(PromotionsLoadingState());
    try {
      final result = await getIt<RemoteServices>().getPromotions();
      result.fold(
        (failure) {
          emit(PromotionsErrorState(failure));
        },
        (products) {
          emit(PromotionsLoadedState(products));
        },
      );
    } catch (e) {
      emit(PromotionsErrorState(e.toString()));
    }
  }
}
