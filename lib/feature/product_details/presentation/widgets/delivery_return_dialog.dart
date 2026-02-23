import 'package:flutter/material.dart';
import 'package:spex/core/helpers/colors/dark_colors.dart';
import 'package:spex/core/helpers/colors/light_colors.dart';
import 'package:spex/main.dart';

import 'package:spex/feature/product_details/presentation/widgets/delivery_return_header.dart';
import 'package:spex/feature/product_details/presentation/widgets/delivery_section.dart';
import 'package:spex/feature/product_details/presentation/widgets/return_section.dart';
import 'package:spex/feature/product_details/presentation/widgets/faq_section.dart';
import 'package:spex/feature/product_details/presentation/widgets/need_help_section.dart';

class DeliveryReturnDialog extends StatelessWidget {
  const DeliveryReturnDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: isDark
          ? AppColorsDark.appBgColor
          : AppColorsLight.whiteColor,
      insetPadding: const EdgeInsets.all(20),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.8,
          maxWidth: MediaQuery.of(context).size.width * 0.9,
        ),
        child: Column(
          children: [
            const DeliveryReturnHeader(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    DeliverySection(),
                    SizedBox(height: 24),
                    ReturnSection(),
                    SizedBox(height: 24),
                    FAQSection(),
                    SizedBox(height: 24),
                    NeedHelpSection(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
