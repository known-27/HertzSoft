import 'package:flutter/material.dart';

class AppColors {
  static const Color loginBackground = Color(0xFFB1B1B1);
  static const Color background = Color(0xFFF5F5F7);
  static const Color widgetBackground = Color(0xFFFFFFFF);
  static const Color textPrimary = Color(0xFF1A1A1A);
  static const Color textSecondary = Color(0xFF434343);
  static const Color ratingText = Color(0xFFFF383C);
  static const Color notification = Color(0xFFFA4545);
  static const Color categoriesButton = Color(0xFF9BD8F7);
  static const Color priceTagColor = Color(0xFFFFC300);
  static const Color activeTageColor = Color(0xFF0088FF);
  static const Color messageBackground = Color(0xFFD3D3F6);
  static const Color defaultProfile = Color(0xFF9BD8F7);

  //Top nav gradient color for widget
  static const LinearGradient topNavGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFA0B7FD), Color(0xFFDCA1E3)],
  );

  //Trending gradient color for widget
  static const LinearGradient trendingGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFA0B7FD), Color(0xFFDCA1E3)],
  );
}

class FontSizes {
  static const small = 12.0;
  static const standard = 14.0;
  static const standardUp = 20.0;
  static const medium = 25.0;
  static const large = 35.0;
}

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: AppColors.background,
      scaffoldBackgroundColor: AppColors.background,
      textTheme: TextTheme(
        titleMedium: TextStyle(
          fontSize: FontSizes.medium,
          color: AppColors.textPrimary,
        ),
        titleSmall: TextStyle(
          fontSize: FontSizes.small,
          color: AppColors.textSecondary,
        ),
        titleLarge: TextStyle(
          fontSize: FontSizes.large,
          color: AppColors.textPrimary,
        ),
        bodyMedium: TextStyle(
          fontSize: FontSizes.standard,
          color: AppColors.textPrimary,
        ),
        bodySmall: TextStyle(
          fontSize: FontSizes.standardUp,
          color: AppColors.textPrimary,
        ),
      ),
    );
  }
}
