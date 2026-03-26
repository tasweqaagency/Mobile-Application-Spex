import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:spex/core/helpers/colors/light_colors.dart';
import 'package:spex/core/widgets/network_image_widget.dart';
import 'package:spex/feature/home/view_model/banner_cubit/banner_cubit.dart';
import 'package:spex/feature/home/view_model/banner_cubit/banner_state.dart';

class TopBannersWidget extends StatelessWidget {
  const TopBannersWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BannerCubit, BannerState>(
      builder: (context, state) {
        if (state is BannerLoadedState && state.topBanners.isNotEmpty) {
          final activeBanners = state.topBanners.where((banner) => banner.isActive).toList();
          
          if (activeBanners.isEmpty) return const SizedBox.shrink();
          
          return CarouselSlider.builder(
            itemCount: activeBanners.length,
            options: CarouselOptions(
              height: 60,
              viewportFraction: 1.0,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 5),
              autoPlayAnimationDuration: const Duration(milliseconds: 1),
              autoPlayCurve: Curves.easeInOut,
              enlargeCenterPage: false,
            ),
            itemBuilder: (context, index, realIndex) {
              return NetworkImageWidget(
                imageUrl: activeBanners[index].image ?? "",
                width: double.infinity,
                fit: BoxFit.cover,

              );
            },
          );
        } else if (state is BannerLoadingState) {
          return const SizedBox(
            height: 60,
            child: Center(
              child: CircularProgressIndicator(
                color: AppColorsLight.mainColor,
              ),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
