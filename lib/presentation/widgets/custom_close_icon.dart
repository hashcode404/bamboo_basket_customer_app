import 'package:flutter/material.dart';
import 'package:bamboo_basket_customer_app/core/theme/app_colors.dart';

class RoundedCloseIcon extends StatelessWidget {
  const RoundedCloseIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context).pop(),
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.kBlack2,
          border: Border.all(color: AppColors.kWhite),
        ),
        child: const Icon(
          Icons.close,
          color: AppColors.kWhite,
        ),
      ),
    );
  }
}
