import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';
import 'custom_text_styles.dart';

ThemeData quickSandTextTheme(BuildContext context) {
  final baseTextTheme = Theme.of(context).textTheme;
  return Theme.of(context).copyWith(
      textTheme: GoogleFonts.quicksandTextTheme(baseTextTheme).apply(
    displayColor: AppColors.kBlack2,
    bodyColor: AppColors.kBlack2,
  ));
}

ThemeData poppinsTextTheme(BuildContext context) {
  final baseTextTheme = Theme.of(context).textTheme;
  return Theme.of(context).copyWith(
      textTheme: GoogleFonts.poppinsTextTheme(baseTextTheme).apply(
    displayColor: AppColors.kBlack2,
    bodyColor: AppColors.kBlack2,
  ));
}

ThemeData appTheme(BuildContext context) {
  final baseTextTheme = Theme.of(context).textTheme;
  final textTheme = GoogleFonts.poppinsTextTheme(baseTextTheme).apply(
    displayColor: AppColors.kBlack2,
    bodyColor: AppColors.kBlack2,
  );

  const double defaultRoundedRadius = 10.0;

  InputDecorationTheme inputDecorationTheme = const InputDecorationTheme(
    hintStyle: TextStyle(fontSize: 14.0),
    border: OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.kGray2), // Default border
      borderRadius: BorderRadius.all(
        Radius.circular(defaultRoundedRadius),
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.kPrimaryColor),
      // Color when focused
      borderRadius: BorderRadius.all(
        Radius.circular(defaultRoundedRadius),
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.kGray2), // Color when enabled
      borderRadius: BorderRadius.all(
        Radius.circular(defaultRoundedRadius),
      ),
    ),
    disabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.kLightGray),
      // Color when disabled
      borderRadius: BorderRadius.all(
        Radius.circular(defaultRoundedRadius),
      ),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.kRed), // Color when error occurs
      borderRadius: BorderRadius.all(
        Radius.circular(defaultRoundedRadius),
      ),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.kRed, width: 2.0),
      // Color when focused and there's an error
      borderRadius: BorderRadius.all(
        Radius.circular(defaultRoundedRadius),
      ),
    ),
  );

  final colorScheme = Theme.of(context).colorScheme;

  return ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: AppColors.kLightWhite,
    appBarTheme: const AppBarTheme(
      color: AppColors.kLightWhite,
      surfaceTintColor: AppColors.kLightWhite,
      elevation: 0,
    ),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: AppColors.kWhite,
    ),
    colorScheme: colorScheme.copyWith(
      primary: AppColors.kBlack2,
    ),
    dropdownMenuTheme: DropdownMenuThemeData(
      inputDecorationTheme: inputDecorationTheme,
    ),
    textTheme: textTheme,
    extensions: [customTextStyle],
    timePickerTheme: const TimePickerThemeData(
      dialHandColor: AppColors.kPrimaryColor,
      backgroundColor: AppColors.kLightWhite,
      dialBackgroundColor: AppColors.kLightWhite,
      hourMinuteShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(defaultRoundedRadius),
        ),
      ),
    ),
    cardTheme: CardTheme(
      color: Colors.transparent,
      elevation: 0,
      margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: const BorderSide(
          color: AppColors.kLightGray,
        ),
      ),
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: AppColors.kWhite,
    ),
    inputDecorationTheme: inputDecorationTheme,
    textButtonTheme: const TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: WidgetStatePropertyAll(AppColors.kBlack3),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(defaultRoundedRadius),
            ),
          ),
        ),
      ),
    ),
    filledButtonTheme: const FilledButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(AppColors.kPrimaryColor),
        foregroundColor: WidgetStatePropertyAll(AppColors.kWhite),
        minimumSize: WidgetStatePropertyAll(Size(200, 50)),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(defaultRoundedRadius),
            ),
            side: BorderSide(
              color: AppColors.kGray2,
            ),
          ),
        ),
      ),
    ),
  );
}
