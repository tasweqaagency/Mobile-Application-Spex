import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:spex/core/widgets/network_image_widget.dart';

class ProductImageWidget extends StatefulWidget {
  const ProductImageWidget({super.key, required this.imageUrl});
  final List<String> imageUrl;

  @override
  State<ProductImageWidget> createState() => _ProductImageWidgetState();
}

class _ProductImageWidgetState extends State<ProductImageWidget> {
  final CarouselSliderController _controller = CarouselSliderController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.15,
      width: double.infinity,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
            child: CarouselSlider.builder(
              carouselController: _controller,
              options: CarouselOptions(
                height: MediaQuery.of(context).size.height * 0.15,
                viewportFraction: 1,
                aspectRatio: 1,
                autoPlay: false,
                enlargeCenterPage: false,
                enlargeFactor: 0.3,
                scrollDirection: Axis.horizontal,
              ),
              itemCount: widget.imageUrl.length,
              itemBuilder: (context, index, realIndex) {
                return NetworkImageWidget(
                  imageUrl: widget.imageUrl[index],
                  // height: widget.height * 0.9,
                  // width: widget.width * 0.9,
                );
              },
            ),
          ),
          // if (widget.imageUrl.length > 1) ...[
          //   _buildArrow(
          //     onPressed: () => _controller.previousPage(),
          //     icon: Icons.arrow_back_ios_new,
          //     left: 5,
          //   ),
          //   _buildArrow(
          //     onPressed: () => _controller.nextPage(),
          //     icon: Icons.arrow_forward_ios,
          //     right: 5,
          //   ),
          // ],
        ],
      ),
    );
  }

  // Widget _buildArrow({
  //   required VoidCallback onPressed,
  //   required IconData icon,
  //   double? left,
  //   double? right,
  // }) {
  //   return Positioned(
  //     left: left,
  //     right: right,
  //     top: 0,
  //     bottom: 0,
  //     child: Center(
  //       child: Container(
  //         decoration: BoxDecoration(
  //           color: Colors.black.withOpacity(0.3),
  //           shape: BoxShape.circle,
  //         ),
  //         child: IconButton(
  //           onPressed: onPressed,
  //           icon: Icon(icon, size: 14, color: Colors.white),
  //           padding: EdgeInsets.zero,
  //           constraints: const BoxConstraints(minWidth: 28, minHeight: 28),
  //           visualDensity: VisualDensity.compact,
  //           // tapTargetSize: MaterialTapTargetSize.shrinkWrap,
  //         ),
  //       ),
  //     ),
  //   );
  // }
}
