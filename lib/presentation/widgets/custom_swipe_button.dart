import 'package:flutter/material.dart';
import 'package:flutter_swipe_button/flutter_swipe_button.dart';
import 'package:aj_customer/core/theme/app_colors.dart';

class CustomSwipeButton extends StatelessWidget {
  const CustomSwipeButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SwipeButton(
      thumb: const Icon(
        Icons.shopping_bag,
        color: AppColors.kBlack3,
      ),
      activeTrackColor: AppColors.kBlack3,
      inactiveThumbColor: AppColors.kWhite,
      thumbPadding: const EdgeInsets.all(2),
      activeThumbColor: AppColors.kWhite,
      width: 200,
      child: const Text(
        "Add To Cart",
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      onSwipe: () {},
    );
  }
}
