import 'package:spex/feature/home/model/slider_banner.dart';
import 'package:spex/feature/home/model/top_banner.dart';

abstract class BannerState {}

class BannerInitialState extends BannerState {}

class BannerLoadingState extends BannerState {}

class BannerLoadedState extends BannerState {
  final List<TopBanner> topBanners;
  final List<SliderBanner> sliderBanners;
  BannerLoadedState(this.topBanners, this.sliderBanners);
}

class BannerErrorState extends BannerState {
  final String errorMessage;

  BannerErrorState(this.errorMessage);
}
