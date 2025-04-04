import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:bamboo_basket_customer_app/core/theme/app_colors.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () => Navigator.pop(context),
        child: Container(
          padding: const EdgeInsets.all(8),
          margin: const EdgeInsets.only(left: 10),
          decoration: BoxDecoration(
              border: Border.all(color: AppColors.kGray2),
              color: AppColors.kWhite,
              shape: BoxShape.circle),
          child: const Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 18,
          ),
        ),
      ),
    );
  }
}
