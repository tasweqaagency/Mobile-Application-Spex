import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import '../../model/promo_banner_model.dart';
import 'promo_banner_card.dart';
import 'carousel_indicators.dart';

class PromoBanner extends StatefulWidget {
  final List<PromoBannerItem> items;

  const PromoBanner({super.key, required this.items});

  @override
  State<PromoBanner> createState() => _PromoBannerState();
}

class _PromoBannerState extends State<PromoBanner> {
  int _currentPage = 0;
  final CarouselSliderController _carouselController =
      CarouselSliderController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider.builder(
          carouselController: _carouselController,
          itemCount: widget.items.length,
          options: CarouselOptions(
            height: MediaQuery.of(context).size.height * 0.18,
            viewportFraction: 1.0,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 7),
            autoPlayAnimationDuration: const Duration(milliseconds: 100),
            autoPlayCurve: Curves.easeInOut,
            enlargeCenterPage: false,
            onPageChanged: (index, reason) {
              setState(() {
                _currentPage = index;
              });
            },
          ),
          itemBuilder: (context, index, realIndex) {
            final item = widget.items[index];
            return PromoBannerCard(item: item);
          },
        ),
        const SizedBox(height: 12),
        CarouselIndicators(
          itemCount: widget.items.length,
          currentPage: _currentPage,
          carouselController: _carouselController,
        ),
      ],
    );
  }
}
