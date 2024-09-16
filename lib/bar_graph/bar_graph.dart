// Suggested code may be subject to a license. Learn more: ~LicenseLog:29256676.
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'bar_data.dart';

class MyBarGraph extends StatelessWidget {
  final double? maxY;
// Suggested code may be subject to a license. Learn more: ~LicenseLog:3226729164.
  final double sunAmount;
  final double monAmount;
  final double tueAmount;
  final double wedAmount;
  final double thuAmount;
  final double friAmount;
  final double satAmount;

// Suggested code may be subject to a license. Learn more: ~LicenseLog:3143998634.
  const MyBarGraph({
    super.key,
    required this.maxY,
    required this.sunAmount,
    required this.monAmount,
    required this.tueAmount,
    required this.wedAmount,
    required this.thuAmount,
    required this.friAmount,
    required this.satAmount,
  });

  @override
  Widget build(BuildContext context) {
    // initialize the bar data
// Suggested code may be subject to a license. Learn more: ~LicenseLog:1346434375.
    BarData myBarData = BarData(
// Suggested code may be subject to a license. Learn more: ~LicenseLog:805476318.
      sunAmount: sunAmount,
      monAmount: monAmount,
      tueAmount: tueAmount,
      wedAmount: wedAmount,
      thuAmount: thuAmount,
      friAmount: friAmount,
      satAmount: satAmount,
    );

// Suggested code may be subject to a license. Learn more: ~LicenseLog:449214877.
    myBarData.initializeBarData();

    return BarChart(
// Suggested code may be subject to a license. Learn more: ~LicenseLog:3252765911.
      BarChartData(
        maxY: maxY,
        barGroups: myBarData.barData
            .map(
              (data) => BarChartGroupData(
                x: data.x,
                barRods: [
                  BarChartRodData(toY: data.y),
                ],
              ),
            )
            .toList(),
      ),
    );
  }
}
