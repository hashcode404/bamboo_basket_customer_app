import 'package:flutter/material.dart';

const Widget horizontalSpaceTiny = SizedBox(width: 5.0);
const Widget horizontalSpaceSmall = SizedBox(width: 10.0);
const Widget horizontalSpaceVerySmall = SizedBox(width: 8.0);
const Widget horizontalSpaceRegular = SizedBox(width: 18.0);
const Widget horizontalSpaceMedium = SizedBox(width: 25.0);
const Widget horizontalSpaceLarge = SizedBox(width: 50.0);

const Widget verticalSpaceTiny = SizedBox(height: 5.0);
const Widget verticalSpaceVerySmall = SizedBox(height: 8.0);
const Widget verticalSpaceSmall = SizedBox(height: 10.0);
const Widget verticalSpaceRegular = SizedBox(height: 18.0);
const Widget verticalSpaceMedium = SizedBox(height: 25.0);
const Widget verticalSpaceLarge = SizedBox(height: 35.0);
const Widget verticalSpaceXLarge = SizedBox(height: 50.0);

// Screen Size helpers
extension ScreenSizeExtension on BuildContext {
  double get screenWidth => MediaQuery.of(this).size.width;
  double get screenHeight => MediaQuery.of(this).size.height;
  double screenHeightPercentage(double percentage) => screenHeight * percentage;
  double screenHeightPercentageWithoutStatusBar(double percentage) =>
      (screenHeight - MediaQuery.of(this).padding.top) * percentage;
  double screenWidthPercentage(double percentage) => screenWidth * percentage;
  TextTheme get textTheme => Theme.of(this).textTheme;

}