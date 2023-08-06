import 'package:crypto_assignment/util/colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static ThemeData lightTheme = ThemeData(
    appBarTheme:  AppBarTheme(color: AppColors.primary),
    colorScheme: ColorScheme.fromSwatch(
      accentColor: const Color(0xFF13B9FF),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    appBarTheme:  AppBarTheme(color: AppColors.primary),
    colorScheme: ColorScheme.fromSwatch(
      accentColor: const Color(0xFF13B9FF),
    ),
  );
}
