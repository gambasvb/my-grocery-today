import 'package:flutter/material.dart';
import '../bar_graph/bar_graph.dart';
import 'package:provider/provider.dart';

import '../data/expense_data.dart';

/// Menampilkan ringkasan pengeluaran dengan visualisasi grafik batang premium.
class ExpenseSummary extends StatelessWidget {
  const ExpenseSummary({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseData>(
      builder: (context, expenseData, child) {
        final dailySummary = expenseData.calculationDailyExpenseSummary();

        // Ekstrak jumlah untuk setiap hari (default ke 0 jika tidak ada data)
        // Menggunakan tanggal dinamis berdasarkan awal minggu
        final startOfWeek = expenseData.startOfWeekDate();
        
        double getAmountForDay(int dayOffset) {
          final date = startOfWeek.add(Duration(days: dayOffset));
          final dateKey = _convertDateToKey(date);
          return dailySummary[dateKey] ?? 0.0;
        }

        final sunAmount = getAmountForDay(0);
        final monAmount = getAmountForDay(1);
        final tueAmount = getAmountForDay(2);
        final wedAmount = getAmountForDay(3);
        final thuAmount = getAmountForDay(4);
        final friAmount = getAmountForDay(5);
        final satAmount = getAmountForDay(6);

        // Hitung nilai Y maksimum untuk grafik
        final maxY = dailySummary.values.isEmpty
            ? 100.0
            : dailySummary.values.reduce((a, b) => a > b ? a : b) * 1.2;

        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Colors.white.withOpacity(0.2),
              width: 1,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Grafik Mingguan',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      '7 Hari',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.9),
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Expanded(
                child: MyBarGraph(
                  maxY: maxY,
                  sunAmount: sunAmount,
                  monAmount: monAmount,
                  tueAmount: tueAmount,
                  wedAmount: wedAmount,
                  thuAmount: thuAmount,
                  friAmount: friAmount,
                  satAmount: satAmount,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  /// Mengkonversi DateTime ke format kunci YYYYMMDD.
  String _convertDateToKey(DateTime dateTime) {
    final year = dateTime.year.toString();
    final month = dateTime.month.toString().padLeft(2, '0');
    final day = dateTime.day.toString().padLeft(2, '0');
    return '$year$month$day';
  }
}
