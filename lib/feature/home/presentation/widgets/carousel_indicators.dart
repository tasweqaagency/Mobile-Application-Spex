import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import '../../../../core/helpers/colors/light_colors.dart';

class CarouselIndicators extends StatelessWidget {
  final int itemCount;
  final int currentPage;
  final CarouselSliderController carouselController;

  const CarouselIndicators({
    super.key,
    required this.itemCount,
    required this.currentPage,
    required this.carouselController,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        itemCount,
        (index) => GestureDetector(
          onTap: () {
            carouselController.animateToPage(index);
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 100),
            margin: const EdgeInsets.symmetric(horizontal: 4),
            width: currentPage == index ? 24 : 8,
            height: 8,
            decoration: BoxDecoration(
              color: currentPage == index
                  ? AppColorsLight.mainColor
                  : AppColorsLight.spexGrayColor,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ),
      ),
    );
  }
}
