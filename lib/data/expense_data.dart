import '../datetime/date_time_helper.dart';
import 'package:flutter/material.dart';
import '../models/expense_item.dart';
import 'hive_database.dart';

/// Provider untuk mengelola state data pengeluaran.
class ExpenseData extends ChangeNotifier {
  // Daftar semua pengeluaran
  List<ExpenseItem> _overAllExpenseList = [];

  // Instance database
  final HiveDatabase _db = HiveDatabase();

  /// Memuat data dari database.
  void prepareData() {
    _overAllExpenseList = _db.readData();
    notifyListeners();
  }

  /// Menyimpan daftar pengeluaran saat ini ke database.
  void saveData() {
    _db.saveData(_overAllExpenseList);
    notifyListeners();
  }

  /// Menghapus semua pengeluaran dari daftar.
  void deleteData() {
    _overAllExpenseList = [];
    notifyListeners();
  }

  /// Mendapatkan daftar semua pengeluaran.
  List<ExpenseItem> getAllExpenseList() => _overAllExpenseList;

  /// Menambahkan pengeluaran baru ke daftar.
  void addNewExpense(ExpenseItem newExpense) {
    _overAllExpenseList.add(newExpense);
    notifyListeners();
  }

  /// Menghapus pengeluaran dari daftar.
  void deleteExpense(ExpenseItem expense) {
    _overAllExpenseList.remove(expense);
    notifyListeners();
  }

  /// Mendapatkan nama hari untuk DateTime tertentu.
  String getDayName(DateTime dateTime) {
    const days = ['Sen', 'Sel', 'Rab', 'Kam', 'Jum', 'Sab', 'Min'];
    return days[dateTime.weekday - 1];
  }

  /// Mendapatkan tanggal awal minggu (Minggu).
  DateTime startOfWeekDate() {
    final today = DateTime.now();
    for (int i = 0; i < 7; i++) {
      if (getDayName(today.subtract(Duration(days: i))) == 'Min') {
        return today.subtract(Duration(days: i));
      }
    }
    throw StateError('Tidak dapat menemukan awal minggu');
  }

  /// Mengkonversi semua pengeluaran menjadi ringkasan harian.
  /// 
  /// Mengembalikan Map dengan kunci string tanggal dan nilai total jumlah.
  Map<String, double> calculationDailyExpenseSummary() {
    final dailyExpenseSummary = <String, double>{};

    for (var expense in _overAllExpenseList) {
      final date = convertDateTimeToString(expense.dateTime);
      final amount = expense.amount;

      dailyExpenseSummary.update(
        date,
        (currentAmount) => currentAmount + amount,
        ifAbsent: () => amount,
      );
    }
    return dailyExpenseSummary;
  }
}
