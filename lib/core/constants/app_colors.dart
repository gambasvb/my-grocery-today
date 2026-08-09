import 'package:flutter/material.dart';

/// Palet warna utama aplikasi My Grocery Today
/// Menggunakan prinsip desain premium dengan kontras yang baik
class AppColors {
  AppColors._();

  // Primary Colors
  static const Color primary = Color(0xFF6C63FF); // Ungu premium
  static const Color primaryLight = Color(0xFF8E87FF);
  static const Color primaryDark = Color(0xFF524AD6);

  // Secondary Colors
  static const Color secondary = Color(0xFFFF6584); // Pink coral
  static const Color secondaryLight = Color(0xFFFF8FA3);
  static const Color secondaryDark = Color(0xFFD64A6B);

  // Background Colors
  static const Color background = Color(0xFFF8F9FC);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceVariant = Color(0xFFF0F2F5);

  // Text Colors
  static const Color textPrimary = Color(0xFF1A1A2E);
  static const Color textSecondary = Color(0xFF6B7280);
  static const Color textHint = Color(0xFF9CA3AF);

  // Status Colors
  static const Color success = Color(0xFF10B981);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFEF4444);
  static const Color info = Color(0xFF3B82F6);

  // Chart Colors
  static const List<Color> chartColors = [
    Color(0xFF6C63FF),
    Color(0xFFFF6584),
    Color(0xFF10B981),
    Color(0xFFF59E0B),
    Color(0xFF3B82F6),
    Color(0xFF8B5CF6),
    Color(0xFFEC4899),
  ];

  // Gradient Definitions
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary, primaryDark],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient secondaryGradient = LinearGradient(
    colors: [secondary, secondaryDark],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient headerGradient = LinearGradient(
    colors: [Color(0xFF6C63FF), Color(0xFF8B5CF6)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient cardGradient = LinearGradient(
    colors: [Color(0xFFFFFFFF), Color(0xFFF8F9FC)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
