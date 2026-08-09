import 'package:flutter/material.dart';
import 'app_colors.dart';

/// Konstanta aplikasi untuk konsistensi desain
class AppConstants {
  AppConstants._();

  // Spacing System (8px grid)
  static const double spacingXS = 4.0;
  static const double spacingS = 8.0;
  static const double spacingM = 16.0;
  static const double spacingL = 24.0;
  static const double spacingXL = 32.0;
  static const double spacingXXL = 48.0;

  // Border Radius
  static const double radiusSM = 8.0;
  static const double radiusMD = 12.0;
  static const double radiusLG = 16.0;
  static const double radiusXL = 20.0;
  static const double radiusFull = 100.0;

  // Shadow Definitions
  static List<BoxShadow> get shadowSM => [
        BoxShadow(
          color: Colors.black.withOpacity(0.05),
          blurRadius: 4,
          offset: const Offset(0, 2),
        ),
      ];

  static List<BoxShadow> get shadowMD => [
        BoxShadow(
          color: Colors.black.withOpacity(0.08),
          blurRadius: 8,
          offset: const Offset(0, 4),
        ),
      ];

  static List<BoxShadow> get shadowLG => [
        BoxShadow(
          color: Colors.black.withOpacity(0.12),
          blurRadius: 16,
          offset: const Offset(0, 8),
        ),
      ];

  // Animation Durations
  static const Duration durationFast = Duration(milliseconds: 200);
  static const Duration durationNormal = Duration(milliseconds: 300);
  static const Duration durationSlow = Duration(milliseconds: 500);

  // Max Width for Responsive Design
  static const double maxWidthMobile = 480.0;
  static const double maxWidthTablet = 768.0;

  // Days of Week (Indonesian)
  static const List<String> daysOfWeek = [
    'Min',
    'Sen',
    'Sel',
    'Rab',
    'Kam',
    'Jum',
    'Sab',
  ];

  // Default Categories
  static const List<Map<String, dynamic>> defaultCategories = [
    {'name': 'Makanan', 'icon': '🍔', 'color': AppColors.primary},
    {'name': 'Transportasi', 'icon': '🚗', 'color': AppColors.secondary},
    {'name': 'Belanja', 'icon': '🛒', 'color': AppColors.success},
    {'name': 'Hiburan', 'icon': '🎬', 'color': AppColors.warning},
    {'name': 'Kesehatan', 'icon': '💊', 'color': AppColors.info},
    {'name': 'Lainnya', 'icon': '📦', 'color': AppColors.textSecondary},
  ];
}
