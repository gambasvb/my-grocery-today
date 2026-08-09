import 'package:dartz/dartz.dart';
import '../../../core/failure/failure.dart';
import '../../../core/usecase/usecase.dart';
import '../../entities/expense.dart';
import '../../repositories/repository.dart';

/// UseCase untuk mendapatkan semua pengeluaran
class GetAllExpenses implements UseCase<List<Expense>, NoParams> {
  final ExpenseRepository repository;

  GetAllExpenses(this.repository);

  @override
  Future<Either<Failure, List<Expense>>> call(NoParams params) async {
    try {
      final expenses = await repository.getAllExpenses();
      return Right(expenses);
    } catch (e) {
      return const Left(DatabaseFailure(message: 'Gagal mengambil data pengeluaran'));
    }
  }
}
