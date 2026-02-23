import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:spex/feature/home/model/product_model.dart';
import 'product_details_promo_card.dart';
import 'product_details_carousel_indicators.dart';

class ProductDetailsBanner extends StatefulWidget {
  final ProductModel product;

  const ProductDetailsBanner({super.key, required this.product});

  @override
  State<ProductDetailsBanner> createState() => _ProductDetailsBannerState();
}

class _ProductDetailsBannerState extends State<ProductDetailsBanner> {
  int _currentPage = 0;
  final CarouselSliderController _carouselController =
      CarouselSliderController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider.builder(
          carouselController: _carouselController,
          itemCount: widget.product.imagePath.length,
          options: CarouselOptions(
            height: MediaQuery.of(context).size.height * 0.225,
            viewportFraction: 0.9,
            enlargeFactor: 0.9,
            enlargeStrategy: CenterPageEnlargeStrategy.scale,
            autoPlay: false,
            aspectRatio: 1.5,
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
            final item = widget.product.imagePath[index];
            return ProductDetailsPromoCard(item: item);
          },
        ),
        const SizedBox(height: 12),
        ProductDetailsCarouselIndicators(
          imageCount: widget.product.imagePath.length,
          currentPage: _currentPage,
          carouselController: _carouselController,
        ),
      ],
    );
  }
}
