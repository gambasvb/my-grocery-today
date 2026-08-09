import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_constants.dart';
import 'summary_card.dart';

/// Molecule: Kartu Ringkasan yang berisi dua SummaryCard (Hari Ini & Minggu Ini)
class SummaryCards extends StatelessWidget {
  final double totalToday;
  final double totalWeek;

  const SummaryCards({
    super.key,
    required this.totalToday,
    required this.totalWeek,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Kartu Hari Ini
        SummaryCard(
          title: 'Hari Ini',
          amount: totalToday,
          icon: Icons.today,
          gradientStart: AppColors.primary,
          gradientEnd: AppColors.primaryDark,
        ),
        
        const SizedBox(width: AppConstants.spacingM),
        
        // Kartu Minggu Ini
        SummaryCard(
          title: 'Minggu Ini',
          amount: totalWeek,
          icon: Icons.calendar_today,
          gradientStart: AppColors.secondary,
          gradientEnd: AppColors.secondaryDark,
        ),
      ],
    );
  }
}
