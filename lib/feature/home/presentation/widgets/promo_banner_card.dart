import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/helpers/colors/light_colors.dart';
import '../../../../core/widgets/text_in_app_widget.dart';
import '../../../../core/helpers/constants/constants.dart';
import '../../model/promo_banner_model.dart';

class PromoBannerCard extends StatelessWidget {
  final PromoBannerItem item;
  const PromoBannerCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: DecorationImage(
          image: NetworkImage(item.imageUrl),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black.withValues(alpha: 0.3),
            BlendMode.darken,
          ),
        ),
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            spacing: 8.w,
            children: [
              TextInAppWidget(
                text: item.title,
                textSize: 16.sp,
                fontWeightIndex: FontSelectionData.boldFontFamily,
                textColor: Colors.white,
              ),
              TextInAppWidget(
                text: item.subtitle,
                textSize: 12.sp,
                fontWeightIndex: FontSelectionData.regularFontFamily,
                textColor: Colors.white.withValues(alpha: 0.9),
                maxLines: 2,
                isEllipsisTextOverflow: true,
              ),
              InkWell(
                onTap: () {},
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 6.h,
                  ),
                  decoration: BoxDecoration(
                    color: AppColorsLight.mainColor,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: AppColorsLight.mainColor.withValues(alpha: 0.3),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextInAppWidget(
                        text: 'Pre-Order Now ',
                        textSize: 10.sp,
                        fontWeightIndex: FontSelectionData.regularFontFamily,
                        textColor: Colors.white,
                      ),
                      const SizedBox(width: 4),
                      Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                        size: 12.sp,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
