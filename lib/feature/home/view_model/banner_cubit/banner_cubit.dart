import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spex/core/di/sl.dart';
import 'package:spex/core/networking/remote_services.dart';
import 'banner_state.dart';

class BannerCubit extends Cubit<BannerState> {
  BannerCubit() : super(BannerInitialState());

  Future<void> getBanners() async {
    emit(BannerLoadingState());
    try {
      final topBannersResult = await getIt<RemoteServices>().getTopBanners();
      final sliderBannersResult = await getIt<RemoteServices>().getSliderBanners();

      topBannersResult.fold(
        (failure) {
          emit(BannerErrorState(failure));
        },
        (topBanners) {
          sliderBannersResult.fold(
            (failure) {
              emit(BannerErrorState(failure));
            },
            (sliderBanners) {
              emit(BannerLoadedState(topBanners, sliderBanners));
            },
          );
        },
      );
    } catch (e) {
      emit(BannerErrorState(e.toString()));
    }
  }
}
