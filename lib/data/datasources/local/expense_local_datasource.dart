import 'package:hive_flutter/hive_flutter.dart';
import '../../domain/entities/expense.dart';

/// Hive Data Source untuk manajemen pengeluaran lokal
abstract class ExpenseLocalDataSource {
  Future<List<Expense>> getAllExpenses();
  Future<Expense?> getExpenseById(String id);
  Future<void> addExpense(Expense expense);
  Future<void> updateExpense(Expense expense);
  Future<void> deleteExpense(String id);
  Future<void> deleteAllExpenses();
}

/// Implementasi Hive untuk ExpenseLocalDataSource
class ExpenseLocalDataSourceImpl implements ExpenseLocalDataSource {
  final Box<Map<dynamic, dynamic>> box;

  ExpenseLocalDataSourceImpl(this.box);

  @override
  Future<List<Expense>> getAllExpenses() async {
    try {
      final expenses = <Expense>[];
      for (final key in box.keys) {
        final data = box.get(key);
        if (data != null) {
          expenses.add(_mapToExpense(data));
        }
      }
      // Sort by date descending
      expenses.sort((a, b) => b.date.compareTo(a.date));
      return expenses;
    } catch (e) {
      throw Exception('Gagal mengambil data: $e');
    }
  }

  @override
  Future<Expense?> getExpenseById(String id) async {
    try {
      final data = box.get(id);
      if (data == null) return null;
      return _mapToExpense(data);
    } catch (e) {
      throw Exception('Gagal mengambil data: $e');
    }
  }

  @override
  Future<void> addExpense(Expense expense) async {
    try {
      await box.put(expense.id, _mapToMap(expense));
    } catch (e) {
      throw Exception('Gagal menambahkan data: $e');
    }
  }

  @override
  Future<void> updateExpense(Expense expense) async {
    try {
      await box.put(expense.id, _mapToMap(expense));
    } catch (e) {
      throw Exception('Gagal memperbarui data: $e');
    }
  }

  @override
  Future<void> deleteExpense(String id) async {
    try {
      await box.delete(id);
    } catch (e) {
      throw Exception('Gagal menghapus data: $e');
    }
  }

  @override
  Future<void> deleteAllExpenses() async {
    try {
      await box.clear();
    } catch (e) {
      throw Exception('Gagal menghapus semua data: $e');
    }
  }

  /// Map dari Hive data ke Expense entity
  Expense _mapToExpense(Map<dynamic, dynamic> data) {
    return Expense(
      id: data['id'] as String,
      amount: (data['amount'] as num).toDouble(),
      description: data['description'] as String,
      date: DateTime.parse(data['date'] as String),
      categoryId: data['categoryId'] as String,
      note: data['note'] as String?,
    );
  }

  /// Map dari Expense entity ke Hive data
  Map<String, dynamic> _mapToMap(Expense expense) {
    return {
      'id': expense.id,
      'amount': expense.amount,
      'description': expense.description,
      'date': expense.date.toIso8601String(),
      'categoryId': expense.categoryId,
      'note': expense.note,
    };
  }
}
