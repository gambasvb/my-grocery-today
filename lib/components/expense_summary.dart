// Suggested code may be subject to a license. Learn more: ~LicenseLog:2423987373.
import 'package:flutter/material.dart';
import 'package:my_grocery_today/bar_graph/bar_graph.dart';
import 'package:provider/provider.dart';

import '../data/expense_data.dart';

class ExpenseSummary extends StatelessWidget {
  final DateTime startOfWeek;
  const ExpenseSummary({super.key, required this.startOfWeek});

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseData>(
      builder: (context, value, child) => const SizedBox(
        height: 200,
        child: MyBarGraph(
            maxY: 100,
            sunAmount: 20,
            monAmount: 50,
            tueAmount: 10,
            wedAmount: 30,
            thuAmount: 24,
            friAmount: 3,
            satAmount: 90),
      ),
    );
  }
}
