import 'package:flutter/material.dart';
import 'package:aj_customer/core/theme/app_colors.dart';

class BottomSheetDragHandler extends StatelessWidget {
  const BottomSheetDragHandler({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.kGray2,
        borderRadius: BorderRadius.circular(20),
      ),
      width: 80,
      height: 7,
    );
  }
}
