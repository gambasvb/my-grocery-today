import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_constants.dart';

/// Organism: Grafik Batang Mingguan
/// Menampilkan pengeluaran 7 hari terakhir dalam bentuk bar chart
class WeeklyChart extends StatelessWidget {
  final Map<DateTime, double> weeklyData;

  const WeeklyChart({
    super.key,
    required this.weeklyData,
  });

  @override
  Widget build(BuildContext context) {
    // Urutkan data berdasarkan tanggal
    final sortedDates = weeklyData.keys.toList()..sort();
    
    // Cari nilai maksimum untuk scaling
    final maxValue = weeklyData.values.isEmpty 
        ? 1.0 
        : weeklyData.values.reduce((a, b) => a > b ? a : b);

    return Container(
      padding: const EdgeInsets.all(AppConstants.spacingM),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppConstants.radiusLG),
        boxShadow: AppConstants.shadowSM,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Grafik Mingguan',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: AppConstants.spacingL),
          
          // Chart Area
          SizedBox(
            height: 150,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: sortedDates.map((date) {
                final amount = weeklyData[date] ?? 0.0;
                final heightRatio = maxValue > 0 ? amount / maxValue : 0;
                
                return _buildBarColumn(
                  date: date,
                  amount: amount,
                  heightRatio: heightRatio,
                  isToday: _isToday(date),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBarColumn({
    required DateTime date,
    required double amount,
    required double heightRatio,
    required bool isToday,
  }) {
    final dayName = AppConstants.daysOfWeek[date.weekday % 7];
    final currencyFormat = NumberFormat.currency(
      locale: 'id_ID',
      symbol: '',
      decimalDigits: 0,
    );

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        // Amount tooltip (only show if has value)
        if (amount > 0)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
            margin: const EdgeInsets.only(bottom: 4),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              currencyFormat.format(amount).replaceAll('.', '').replaceAll(',', '.'),
              style: TextStyle(
                fontSize: 8,
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        
        // Bar
        Expanded(
          child: Container(
            width: 32,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: isToday
                    ? [AppColors.secondary, AppColors.secondaryDark]
                    : [AppColors.primary, AppColors.primaryDark],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(6),
              ),
            ),
            height: heightRatio * 120, // Max height 120
          ),
        ),
        
        const SizedBox(height: 8),
        
        // Day label
        Text(
          dayName,
          style: TextStyle(
            fontSize: 11,
            color: isToday ? AppColors.primary : AppColors.textSecondary,
            fontWeight: isToday ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ],
    );
  }

  bool _isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }
}
