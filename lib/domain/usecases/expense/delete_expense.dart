import 'package:dartz/dartz.dart';
import '../../../core/failure/failure.dart';
import '../../../core/usecase/usecase.dart';
import '../../entities/expense.dart';
import '../../repositories/repository.dart';

/// UseCase untuk menghapus pengeluaran
class DeleteExpense implements UseCase<void, DeleteExpenseParams> {
  final ExpenseRepository repository;

  DeleteExpense(this.repository);

  @override
  Future<Either<Failure, void>> call(DeleteExpenseParams params) async {
    try {
      await repository.deleteExpense(params.id);
      return const Right(null);
    } catch (e) {
      return const Left(DatabaseFailure(message: 'Gagal menghapus pengeluaran'));
    }
  }
}

/// Parameter untuk DeleteExpense UseCase
class DeleteExpenseParams {
  final String id;

  const DeleteExpenseParams({required this.id});
}
