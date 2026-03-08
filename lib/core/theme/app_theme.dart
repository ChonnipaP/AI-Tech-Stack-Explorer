// lib/core/theme/app_theme.dart
import 'package:flutter/material.dart';

// ── สีทั้งหมดของแอป ──────────────────────────────────
class AppColors {
  // พื้นหลัง
  static const background  = Color(0xFF0A0E1A); // สีดำน้ำเงิน (หลัก)
  static const surface     = Color(0xFF141B2D); // สี Card
  static const surfaceVar  = Color(0xFF1E2A3A); // สี Card เมื่อ hover/expand

  // สีหลัก
  static const primary     = Color(0xFF00D4AA); // Teal (Bloomberg)
  static const secondary   = Color(0xFF2979FF); // น้ำเงิน

  // สีแจ้งเตือน
  static const warning     = Color(0xFFFF6B35); // ส้ม
  static const positive    = Color(0xFF00C853); // เขียว (หุ้นขึ้น)
  static const negative    = Color(0xFFFF3B5C); // แดง (หุ้นลง)

  // สีข้อความ
  static const textPrimary = Color(0xFFE8EAF0); // ข้อความหลัก
  static const textSecond  = Color(0xFF8892A4); // ข้อความรอง

  // อื่นๆ
  static const divider     = Color(0xFF2A3A4A); // เส้นแบ่ง
}

// ── Theme หลักของแอป ─────────────────────────────────
class AppTheme {
  // Dark Mode (Bloomberg Style)
  static ThemeData get dark => ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.background,

    colorScheme: const ColorScheme.dark(
      surface:      AppColors.surface,
      primary:      AppColors.primary,
      secondary:    AppColors.secondary,
      error:        AppColors.negative,
      onPrimary:    Colors.black,
      onSurface:    AppColors.textPrimary,
    ),

    // AppBar
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.surface,
      foregroundColor: AppColors.textPrimary,
      elevation: 0,
      centerTitle: false,
      titleTextStyle: TextStyle(
        color: AppColors.primary,
        fontSize: 18,
        fontWeight: FontWeight.bold,
        letterSpacing: 0.5,
      ),
    ),

    // Card
    cardTheme: CardTheme(
      color: AppColors.surface,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(
          color: AppColors.divider,
          width: 0.5,
        ),
      ),
    ),

    // ElevatedButton
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(
          vertical: 14,
          horizontal: 20,
        ),
        textStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      ),
    ),

    // OutlinedButton
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.primary,
        side: const BorderSide(color: AppColors.primary),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),

    // Input / TextField
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.surfaceVar,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.divider),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.divider),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(
          color: AppColors.primary,
          width: 1.5,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.negative),
      ),
      labelStyle: const TextStyle(color: AppColors.textSecond),
      hintStyle: const TextStyle(color: AppColors.textSecond),
    ),

    // Bottom Navigation Bar
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColors.surface,
      selectedItemColor: AppColors.primary,
      unselectedItemColor: AppColors.textSecond,
      type: BottomNavigationBarType.fixed,
      elevation: 0,
    ),

    // Divider
    dividerTheme: const DividerThemeData(
      color: AppColors.divider,
      thickness: 0.5,
    ),

    // SnackBar
    snackBarTheme: SnackBarThemeData(
      backgroundColor: AppColors.surfaceVar,
      contentTextStyle: const TextStyle(color: AppColors.textPrimary),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      behavior: SnackBarBehavior.floating,
    ),
  );

  // Light Mode (สำหรับ toggle)
  static ThemeData get light => ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primary,
    ),
  );
}
