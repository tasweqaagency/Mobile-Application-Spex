import 'package:flutter/material.dart';
import 'package:spex/core/helpers/colors/light_colors.dart';
import 'package:spex/core/helpers/constants/constants.dart';
import 'package:spex/core/helpers/extentions/extentions.dart';
import 'package:spex/core/widgets/text_in_app_widget.dart';

class ProfileStatCard extends StatelessWidget {
  final String value;
  final String label;

  const ProfileStatCard({super.key, required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      padding: EdgeInsets.symmetric(vertical: 16),
      decoration: myBoxDecoration(),
      child: Column(
        children: [
          TextInAppWidget(
            text: value,
            textSize: 20,
            fontWeightIndex: FontSelectionData.boldFontFamily,
            textColor: AppColorsLight.mainColor,
          ),
          verticalSpace(4),
          TextInAppWidget(
            text: label.toUpperCase(),
            textSize: 10,
            fontWeightIndex: FontSelectionData.semiBoldFontFamily,
            textColor: AppColorsLight.appSecondTextColor,
          ),
        ],
      ),
    );
  }
}

class ProfileStatsRow extends StatelessWidget {
  final String ordersCount;
  final String couponsCount;
  final String pointsCount;

  const ProfileStatsRow({
    super.key,
    required this.ordersCount,
    required this.couponsCount,
    required this.pointsCount,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ProfileStatCard(value: ordersCount, label: "Orders"),
        ProfileStatCard(value: couponsCount, label: "Coupons"),
        ProfileStatCard(value: pointsCount, label: "Points"),
      ],
    );
  }
}
