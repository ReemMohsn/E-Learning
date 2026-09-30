import 'package:flutter/material.dart';

import 'app_color.dart';

abstract final class AppTheme {
  static ThemeData get lightTheme {
    final colors =
        ColorScheme.fromSeed(
          seedColor: AppColor.primary,
          brightness: Brightness.light,
        ).copyWith(
          primary: AppColor.primary,
          surface: AppColor.surface,
          onSurface: AppColor.textPrimary,
          onSurfaceVariant: AppColor.textSecondary,
          outlineVariant: AppColor.outline,
        );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colors,
      scaffoldBackgroundColor: AppColor.background,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColor.background,
        foregroundColor: AppColor.textPrimary,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
      ),
      cardTheme: CardThemeData(
        color: AppColor.surface,
        elevation: 0,
        margin: EdgeInsets.zero,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: AppColor.outline),
        ),
      ),
    );
  }
}
