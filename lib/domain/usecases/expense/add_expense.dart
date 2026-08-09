import 'package:dartz/dartz.dart';
import '../../../core/failure/failure.dart';
import '../../../core/usecase/usecase.dart';
import '../../entities/expense.dart';
import '../../repositories/repository.dart';

/// UseCase untuk menambahkan pengeluaran baru
class AddExpense implements UseCase<void, AddExpenseParams> {
  final ExpenseRepository repository;

  AddExpense(this.repository);

  @override
  Future<Either<Failure, void>> call(AddExpenseParams params) async {
    try {
      await repository.addExpense(params.expense);
      return const Right(null);
    } catch (e) {
      return const Left(DatabaseFailure(message: 'Gagal menambahkan pengeluaran'));
    }
  }
}

/// Parameter untuk AddExpense UseCase
class AddExpenseParams {
  final Expense expense;

  const AddExpenseParams({required this.expense});
}
