import 'package:dartz/dartz.dart';
import '../../../core/failure/failure.dart';
import '../../../domain/entities/expense.dart';
import '../../../domain/repositories/repository.dart';
import '../datasources/local/expense_local_datasource.dart';

/// Implementasi repository untuk Expense
class ExpenseRepositoryImpl implements ExpenseRepository {
  final ExpenseLocalDataSource localDataSource;

  ExpenseRepositoryImpl(this.localDataSource);

  @override
  Future<List<Expense>> getAllExpenses() {
    return localDataSource.getAllExpenses();
  }

  @override
  Future<Expense?> getExpenseById(String id) {
    return localDataSource.getExpenseById(id);
  }

  @override
  Future<List<Expense>> getExpensesByDate(DateTime date) async {
    final allExpenses = await localDataSource.getAllExpenses();
    return allExpenses.where((expense) {
      return expense.date.year == date.year &&
          expense.date.month == date.month &&
          expense.date.day == date.day;
    }).toList();
  }

  @override
  Future<List<Expense>> getExpensesByDateRange(DateTime start, DateTime end) async {
    final allExpenses = await localDataSource.getAllExpenses();
    return allExpenses.where((expense) {
      return expense.date.isAfter(start.subtract(const Duration(days: 1))) &&
          expense.date.isBefore(end.add(const Duration(days: 1)));
    }).toList();
  }

  @override
  Future<void> addExpense(Expense expense) {
    return localDataSource.addExpense(expense);
  }

  @override
  Future<void> updateExpense(Expense expense) {
    return localDataSource.updateExpense(expense);
  }

  @override
  Future<void> deleteExpense(String id) {
    return localDataSource.deleteExpense(id);
  }

  @override
  Future<void> deleteAllExpenses() {
    return localDataSource.deleteAllExpenses();
  }

  @override
  Future<double> getTotalExpenseByDate(DateTime date) async {
    final expenses = await getExpensesByDate(date);
    return expenses.fold(0.0, (sum, expense) => sum + expense.amount);
  }

  @override
  Future<double> getTotalExpenseByDateRange(DateTime start, DateTime end) async {
    final expenses = await getExpensesByDateRange(start, end);
    return expenses.fold(0.0, (sum, expense) => sum + expense.amount);
  }

  @override
  Future<Map<String, double>> getExpensesByCategory() async {
    final allExpenses = await localDataSource.getAllExpenses();
    final Map<String, double> categoryTotals = {};
    
    for (var expense in allExpenses) {
      categoryTotals[expense.categoryId] = 
          (categoryTotals[expense.categoryId] ?? 0) + expense.amount;
    }
    
    return categoryTotals;
  }
}
