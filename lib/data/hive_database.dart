import 'package:hive_flutter/hive_flutter.dart';

import '../models/expense_item.dart';

/// Helper database Hive untuk persistensi pengeluaran.
class HiveDatabase {
  // Referensi ke box Hive
  final _myBox = Hive.box('expenses_database');

  /// Menyimpan semua pengeluaran ke database.
  /// 
  /// [allExpense] adalah daftar ExpenseItem yang akan disimpan.
  void saveData(List<ExpenseItem> allExpense) {
    final allExpensesFormatted = allExpense
        .map((expense) => [
              expense.name,
              expense.amount,
              expense.dateTime,
            ])
        .toList();
    _myBox.put('ALL_EXPENSES', allExpensesFormatted);
  }

  /// Membaca semua pengeluaran dari database.
  /// 
  /// Mengembalikan List<ExpenseItem> dari data yang tersimpan.
  List<ExpenseItem> readData() {
    final savedExpenses = _myBox.get('ALL_EXPENSES') ?? <List<dynamic>>[];
    return savedExpenses
        .map((expense) => ExpenseItem(
              name: expense[0] as String,
              amount: (expense[1] as num).toDouble(),
              dateTime: expense[2] as DateTime,
            ))
        .toList();
  }
}
