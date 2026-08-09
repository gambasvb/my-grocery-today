import 'package:dartz/dartz.dart';
import '../../../core/failure/failure.dart';
import '../../../core/usecase/usecase.dart';
import '../../entities/expense.dart';
import '../../repositories/repository.dart';

/// UseCase untuk mendapatkan total pengeluaran mingguan
class GetWeeklyExpenses implements UseCase<Map<DateTime, double>, NoParams> {
  final ExpenseRepository repository;

  GetWeeklyExpenses(this.repository);

  @override
  Future<Either<Failure, Map<DateTime, double>>> call(NoParams params) async {
    try {
      // Hitung 7 hari terakhir
      final now = DateTime.now();
      final startDate = now.subtract(const Duration(days: 6));
      
      final expenses = await repository.getExpensesByDateRange(startDate, now);
      
      // Group by date
      final Map<DateTime, double> dailyTotals = {};
      for (var expense in expenses) {
        final date = DateTime(expense.date.year, expense.date.month, expense.date.day);
        dailyTotals[date] = (dailyTotals[date] ?? 0) + expense.amount;
      }
      
      // Pastikan ada entry untuk 7 hari terakhir (meski 0)
      for (int i = 0; i < 7; i++) {
        final date = now.subtract(Duration(days: 6 - i));
        final normalizedDate = DateTime(date.year, date.month, date.day);
        dailyTotals.putIfAbsent(normalizedDate, () => 0.0);
      }
      
      return Right(dailyTotals);
    } catch (e) {
      return const Left(DatabaseFailure(message: 'Gagal mengambil data mingguan'));
    }
  }
}
