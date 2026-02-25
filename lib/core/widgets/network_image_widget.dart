import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:spex/core/helpers/colors/light_colors.dart';

class NetworkImageWidget extends StatelessWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;
  final BorderRadius? borderRadius;

  const NetworkImageWidget({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    if (imageUrl.isEmpty) {
      return Container(
        width: width ?? double.infinity,
        height: height ?? double.infinity,
        decoration: BoxDecoration(
          color: AppColorsLight.spexGrayColor,
          borderRadius: borderRadius ?? BorderRadius.zero,
        ),
        child: const Icon(
          Icons.image_not_supported_outlined,
          color: AppColorsLight.black50Color,
        ),
      );
    }
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.zero,
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        width: width,
        height: height,
        fit: fit,
        placeholder: (context, url) => Shimmer.fromColors(
          baseColor: AppColorsLight.spexGrayColor,
          highlightColor: AppColorsLight.whiteColor,
          child: Container(
            width: width ?? double.infinity,
            height: height ?? double.infinity,
            color: Colors.white,
          ),
        ),
        errorWidget: (context, url, error) => Container(
          width: width ?? double.infinity,
          height: height ?? double.infinity,
          color: AppColorsLight.spexGrayColor,
          child: const Icon(
            Icons.error_outline,
            color: AppColorsLight.black50Color,
          ),
        ),
      ),
    );
  }
}
