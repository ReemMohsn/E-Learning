import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_color.dart';

abstract final class AppTheme {
  static const double fieldRadius = 12;
  static const double buttonRadius = 12;
  static const double homeMaxWidth = 1200;
  static const double courseDetailsMaxWidth = 720;
  static const double homeSpacing = 16;
  static const homePadding = EdgeInsets.fromLTRB(18, 26, 18, 24);
  static const homeHeaderPadding = EdgeInsets.fromLTRB(20, 28, 20, 24);
  static const coursePadding = EdgeInsets.all(8);
  static const courseImageRadius = BorderRadius.all(Radius.circular(12));
  static const homeHeaderShape = RoundedRectangleBorder(
    borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
  );

  static ThemeData get lightTheme {
    final inputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(fieldRadius),
      borderSide: const BorderSide(color: AppColor.inputBorder),
    );
    final buttonStyle = ElevatedButton.styleFrom(
      backgroundColor: AppColor.primary,
      foregroundColor: AppColor.onPrimary,
      minimumSize: const Size(64, 50),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 13),
      elevation: 5,
      shadowColor: AppColor.shadow,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(buttonRadius),
      ),
      textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: const ColorScheme.light(
        primary: AppColor.primary,
        onPrimary: AppColor.onPrimary,
        secondary: AppColor.secondary,
        onSecondary: AppColor.textPrimary,
        secondaryContainer: AppColor.softAccent,
        onSecondaryContainer: AppColor.primary,
        surface: AppColor.surface,
        onSurface: AppColor.textPrimary,
        onSurfaceVariant: AppColor.textSecondary,
        outline: AppColor.inputBorder,
        outlineVariant: AppColor.divider,
        error: AppColor.danger,
        onError: Colors.white,
      ),
      scaffoldBackgroundColor: AppColor.background,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColor.primary,
        foregroundColor: AppColor.onPrimary,
        surfaceTintColor: Colors.transparent,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        elevation: 2,
        shadowColor: AppColor.shadow,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: AppColor.onPrimary,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.w700,
          color: AppColor.textPrimary,
        ),
        headlineMedium: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.w700,
          color: AppColor.textPrimary,
        ),
        headlineSmall: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w700,
          color: AppColor.textPrimary,
        ),
        titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        titleSmall: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        bodyLarge: TextStyle(
          fontSize: 16,
          height: 1.6,
          color: AppColor.textSecondary,
        ),
        bodyMedium: TextStyle(fontSize: 14, color: AppColor.textSecondary),
        bodySmall: TextStyle(fontSize: 12, color: AppColor.textSecondary),
        labelLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        labelMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        labelSmall: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
      ),
      cardTheme: CardThemeData(
        color: AppColor.surface,
        surfaceTintColor: Colors.transparent,
        elevation: 2,
        shadowColor: AppColor.shadow,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColor.inputField,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        hintStyle: const TextStyle(fontSize: 16, color: AppColor.hint),
        labelStyle: const TextStyle(
          fontSize: 14,
          color: AppColor.textSecondary,
        ),
        prefixIconColor: AppColor.primary,
        suffixIconColor: AppColor.hint,
        border: inputBorder,
        enabledBorder: inputBorder,
        focusedBorder: inputBorder.copyWith(
          borderSide: const BorderSide(color: AppColor.primary, width: 1.5),
        ),
        errorBorder: inputBorder.copyWith(
          borderSide: const BorderSide(color: AppColor.danger),
        ),
        focusedErrorBorder: inputBorder.copyWith(
          borderSide: const BorderSide(color: AppColor.danger, width: 1.5),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(style: buttonStyle),
      filledButtonTheme: FilledButtonThemeData(style: buttonStyle),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColor.primary,
          textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColor.primary,
        selectedItemColor: AppColor.onPrimary,
        unselectedItemColor: AppColor.navigationInactive,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: TextStyle(fontSize: 12),
        selectedIconTheme: IconThemeData(size: 24),
        unselectedIconTheme: IconThemeData(size: 24),
        showUnselectedLabels: true,
        elevation: 0,
      ),
      navigationBarTheme: NavigationBarThemeData(
        height: 68,
        backgroundColor: AppColor.primary,
        surfaceTintColor: Colors.transparent,
        indicatorColor: Colors.transparent,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        iconTheme: WidgetStateProperty.resolveWith(
          (states) => IconThemeData(
            size: 24,
            color: states.contains(WidgetState.selected)
                ? AppColor.onPrimary
                : AppColor.navigationInactive,
          ),
        ),
        labelTextStyle: WidgetStateProperty.resolveWith(
          (states) => TextStyle(
            fontSize: 12,
            fontWeight: states.contains(WidgetState.selected)
                ? FontWeight.w600
                : FontWeight.w400,
            color: states.contains(WidgetState.selected)
                ? AppColor.onPrimary
                : AppColor.navigationInactive,
          ),
        ),
      ),
      dividerTheme: const DividerThemeData(
        color: AppColor.divider,
        thickness: 1,
      ),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: AppColor.primary,
        linearTrackColor: AppColor.inputBorder,
      ),
      snackBarTheme: const SnackBarThemeData(
        backgroundColor: AppColor.textPrimary,
        contentTextStyle: TextStyle(color: Colors.white, fontSize: 14),
      ),
    );
  }
}
