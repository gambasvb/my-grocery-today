import '../entities/expense.dart';
import '../entities/category.dart';

/// Repository interface untuk manajemen pengeluaran
/// Mendefinisikan kontrak operasi yang harus diimplementasikan oleh layer data
abstract class ExpenseRepository {
  /// Mendapatkan semua pengeluaran
  Future<List<Expense>> getAllExpenses();

  /// Mendapatkan pengeluaran berdasarkan ID
  Future<Expense?> getExpenseById(String id);

  /// Mendapatkan pengeluaran untuk tanggal tertentu
  Future<List<Expense>> getExpensesByDate(DateTime date);

  /// Mendapatkan pengeluaran dalam rentang tanggal
  Future<List<Expense>> getExpensesByDateRange(DateTime start, DateTime end);

  /// Menambahkan pengeluaran baru
  Future<void> addExpense(Expense expense);

  /// Memperbarui pengeluaran yang ada
  Future<void> updateExpense(Expense expense);

  /// Menghapus pengeluaran berdasarkan ID
  Future<void> deleteExpense(String id);

  /// Menghapus semua pengeluaran
  Future<void> deleteAllExpenses();

  /// Mendapatkan total pengeluaran untuk tanggal tertentu
  Future<double> getTotalExpenseByDate(DateTime date);

  /// Mendapatkan total pengeluaran dalam rentang tanggal
  Future<double> getTotalExpenseByDateRange(DateTime start, DateTime end);

  /// Mendapatkan pengeluaran grouped by kategori
  Future<Map<String, double>> getExpensesByCategory();
}

/// Repository interface untuk manajemen kategori
abstract class CategoryRepository {
  /// Mendapatkan semua kategori
  Future<List<Category>> getAllCategories();

  /// Mendapatkan kategori berdasarkan ID
  Future<Category?> getCategoryById(String id);

  /// Menambahkan kategori baru
  Future<void> addCategory(Category category);

  /// Memperbarui kategori yang ada
  Future<void> updateCategory(Category category);

  /// Menghapus kategori berdasarkan ID
  Future<void> deleteCategory(String id);

  /// Mendapatkan kategori default
  Future<List<Category>> getDefaultCategories();
}
