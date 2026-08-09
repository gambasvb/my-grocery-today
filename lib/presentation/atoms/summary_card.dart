import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_constants.dart';

/// Atom: Kartu Ringkasan untuk menampilkan total pengeluaran
class SummaryCard extends StatelessWidget {
  final String title;
  final double amount;
  final IconData icon;
  final Color gradientStart;
  final Color gradientEnd;

  const SummaryCard({
    super.key,
    required this.title,
    required this.amount,
    required this.icon,
    this.gradientStart = AppColors.primary,
    this.gradientEnd = AppColors.primaryDark,
  });

  @override
  Widget build(BuildContext context) {
    final currencyFormat = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    );

    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(AppConstants.spacingM),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [gradientStart, gradientEnd],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(AppConstants.radiusLG),
          boxShadow: AppConstants.shadowMD,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(AppConstants.spacingS),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(AppConstants.radiusMD),
                  ),
                  child: Icon(
                    icon,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ],
            ),
            const Spacer(),
            Text(
              title,
              style: TextStyle(
                fontSize: 12,
                color: Colors.white.withOpacity(0.9),
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: AppConstants.spacingXS),
            Text(
              currencyFormat.format(amount),
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
