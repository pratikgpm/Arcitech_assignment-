import 'package:flutter/material.dart';
import 'app_pallete.dart';

class AppTheme {
  static ThemeData get theme {
    return ThemeData(
        fontFamily: 'poppins',
        scaffoldBackgroundColor: Pallete.whiteColor,
        bottomNavigationBarTheme:
            const BottomNavigationBarThemeData(backgroundColor: Pallete.whiteColor));
  }
}
