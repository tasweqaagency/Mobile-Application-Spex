import 'package:flutter/material.dart';
import 'package:spex/core/helpers/colors/dark_colors.dart';
import 'package:spex/core/helpers/colors/light_colors.dart';
import 'package:spex/core/helpers/constants/constants.dart';
import 'package:spex/core/helpers/extentions/extentions.dart';
import 'package:spex/core/widgets/text_in_app_widget.dart';
import 'package:spex/main.dart';

class CustomPaginationWidget extends StatelessWidget {
  final int currentPage;
  final int totalPages;
  final ValueChanged<int> onPageChanged;

  const CustomPaginationWidget({
    super.key,
    required this.currentPage,
    required this.totalPages,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    if (totalPages < 1) return const SizedBox.shrink();

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildNavButton(
            icon: Icons.arrow_back_ios,
            isEnabled: currentPage > 1,
            onTap: () => onPageChanged(currentPage - 1),
          ),
          ..._buildPageList(),
          _buildNavButton(
            icon: Icons.arrow_forward_ios,
            isEnabled: currentPage < totalPages,
            onTap: () => onPageChanged(currentPage + 1),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildPageList() {
    List<Widget> list = [];

    // Always show first page
    list.add(_buildPageButton(1));

    int start = currentPage - 1;
    int end = currentPage + 1;

    if (start <= 2) {
      start = 2;
    } else {
      list.add(_buildEllipsis());
    }

    if (end >= totalPages - 1) {
      end = totalPages - 1;
    }

    for (int i = start; i <= end; i++) {
      list.add(_buildPageButton(i));
    }

    if (end < totalPages - 1) {
      list.add(_buildEllipsis());
    }

    if (totalPages > 1) {
      list.add(_buildPageButton(totalPages));
    }

    return list;
  }

  Widget _buildPageButton(int page) {
    bool isActive = page == currentPage;
    Color activeColor = isDark
        ? AppColorsDark.mainColor
        : AppColorsLight.mainColor;
    Color textColor = isActive
        ? AppColorsLight.whiteColor
        : (isDark ? AppColorsDark.appTextColor : AppColorsLight.appTextColor);
    Color bgColor = isActive ? activeColor : Colors.transparent;
    Color borderColor = isActive
        ? activeColor
        : (isDark
              ? AppColorsDark.spexGrayColor.withOpacity(0.3)
              : AppColorsLight.spexGrayColor);

    return InkWell(
      onTap: () => onPageChanged(page),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: borderColor),
        ),
        child: TextInAppWidget(
          text: '$page',
          textColor: textColor,
          fontWeightIndex: isActive
              ? FontSelectionData.boldFontFamily
              : FontSelectionData.regularFontFamily,
          textSize: 14,
        ),
      ),
    );
  }

  Widget _buildNavButton({
    required IconData icon,
    required bool isEnabled,
    required VoidCallback onTap,
  }) {
    Color activeColor = isDark
        ? AppColorsDark.mainColor
        : AppColorsLight.mainColor;
    return InkWell(
      onTap: isEnabled ? onTap : null,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isDark
                ? AppColorsDark.spexGrayColor.withOpacity(0.3)
                : AppColorsLight.spexGrayColor,
          ),
        ),
        child: Icon(
          icon,
          size: 14,
          color: isEnabled ? activeColor : AppColorsLight.spexGrayColor,
        ),
      ),
    );
  }

  Widget _buildEllipsis() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 4),
      child: TextInAppWidget(
        text: '...',
        textColor: AppColorsLight.appSecondTextColor,
        textSize: 14,
      ),
    );
  }
}
