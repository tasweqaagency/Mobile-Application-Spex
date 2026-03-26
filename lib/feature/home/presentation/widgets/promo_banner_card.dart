import 'package:flutter/material.dart';
import '../../../../core/widgets/network_image_widget.dart';
import '../../model/slider_banner.dart';

class PromoBannerCard extends StatelessWidget {
  final SliderBanner item;
  const PromoBannerCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Stack(
        children: [
          NetworkImageWidget(
            imageUrl: item.image ?? "",
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.fill,
          ),
          Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.black.withValues(alpha: 0.3),
          ),
        ],
      ),
    );
  }
}
