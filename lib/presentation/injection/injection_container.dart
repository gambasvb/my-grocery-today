import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../data/datasources/local/expense_local_datasource.dart';
import '../../data/repositories/expense_repository_impl.dart';
import '../../domain/repositories/repository.dart';
import '../../domain/usecases/expense/get_all_expenses.dart';
import '../../domain/usecases/expense/add_expense.dart';
import '../../domain/usecases/expense/delete_expense.dart';
import '../../domain/usecases/expense/get_weekly_expenses.dart';
import '../../presentation/bloc/expense/expense_bloc.dart';

/// Dependency Injection menggunakan GetIt
final sl = GetIt.instance;

/// Inisialisasi semua dependencies
Future<void> initDependencies() async {
  // Hive Box untuk expenses
  final expenseBox = await Hive.openBox<Map<dynamic, dynamic>>('expenses');
  sl.registerSingleton<Box<Map<dynamic, dynamic>>>('expenseBox', instanceName: 'expenseBox');

  // Data Sources
  sl.registerLazySingleton<ExpenseLocalDataSource>(
    () => ExpenseLocalDataSourceImpl(
      sl<Box<Map<dynamic, dynamic>>>(instanceName: 'expenseBox'),
    ),
  );

  // Repositories
  sl.registerLazySingleton<ExpenseRepository>(
    () => ExpenseRepositoryImpl(sl<ExpenseLocalDataSource>()),
  );

  // Use Cases
  sl.registerLazySingleton(() => GetAllExpenses(sl<ExpenseRepository>()));
  sl.registerLazySingleton(() => AddExpense(sl<ExpenseRepository>()));
  sl.registerLazySingleton(() => DeleteExpense(sl<ExpenseRepository>()));
  sl.registerLazySingleton(() => GetWeeklyExpenses(sl<ExpenseRepository>()));

  // BLoCs
  sl.registerFactory(
    () => ExpenseBloc(
      getAllExpenses: sl<GetAllExpenses>(),
      addExpense: sl<AddExpense>(),
      deleteExpense: sl<DeleteExpense>(),
      getWeeklyExpenses: sl<GetWeeklyExpenses>(),
    ),
  );
}
