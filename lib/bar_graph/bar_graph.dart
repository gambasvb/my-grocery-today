import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'bar_data.dart';

/// Widget grafik batang untuk memvisualisasikan data pengeluaran mingguan dengan desain premium.
class MyBarGraph extends StatelessWidget {
  final double _maxY;
  final double _sunAmount;
  final double _monAmount;
  final double _tueAmount;
  final double _wedAmount;
  final double _thuAmount;
  final double _friAmount;
  final double _satAmount;

  /// Membuat grafik batang dengan parameter yang diperlukan.
  const MyBarGraph({
    super.key,
    required double maxY,
    required double sunAmount,
    required double monAmount,
    required double tueAmount,
    required double wedAmount,
    required double thuAmount,
    required double friAmount,
    required double satAmount,
  })  : _maxY = maxY,
        _sunAmount = sunAmount,
        _monAmount = monAmount,
        _tueAmount = tueAmount,
        _wedAmount = wedAmount,
        _thuAmount = thuAmount,
        _friAmount = friAmount,
        _satAmount = satAmount;

  @override
  Widget build(BuildContext context) {
    // Inisialisasi data batang
    final myBarData = BarData(
      sunAmount: _sunAmount,
      monAmount: _monAmount,
      tueAmount: _tueAmount,
      wedAmount: _wedAmount,
      thuAmount: _thuAmount,
      friAmount: _friAmount,
      satAmount: _satAmount,
    );

    myBarData.initializeBarData();

    return BarChart(
      BarChartData(
        maxY: _maxY,
        barTouchData: BarTouchData(
          enabled: true,
          touchTooltipData: BarTouchTooltipData(
            getTooltipColor: (group) => Colors.white,
            tooltipPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            tooltipMargin: 8,
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              return BarTooltipItem(
                'Rp ${rod.toY.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\\d{1,3})(?=(\\d{3})+(?!\\d))'), (m) => '${m[1]}.')}',
                const TextStyle(
                  color: Color(0xFF6C63FF),
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              );
            },
          ),
        ),
        gridData: FlGridData(
          show: false,
        ),
        borderData: FlBorderData(
          show: false,
        ),
        titlesData: FlTitlesData(
          show: true,
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                const days = ['Min', 'Sen', 'Sel', 'Rab', 'Kam', 'Jum', 'Sab'];
                if (value.toInt() < 0 || value.toInt() > 6) {
                  return const SizedBox();
                }
                return Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    days[value.toInt()],
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                );
              },
              reservedSize: 32,
            ),
          ),
          leftTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          topTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          rightTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
        ),
        barGroups: myBarData.barData
            .map(
              (data) => BarChartGroupData(
                x: data.x,
                barRods: [
                  BarChartRodData(
                    toY: data.y,
                    gradient: LinearGradient(
                      colors: [
                        const Color(0xFF6C63FF),
                        const Color(0xFFFF6584),
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                    width: 20,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                    ),
                  ),
                ],
              ),
            )
            .toList(),
      ),
    );
  }
}
