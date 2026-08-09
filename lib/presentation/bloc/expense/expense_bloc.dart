import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../domain/entities/expense.dart';
import '../../../domain/usecases/expense/get_all_expenses.dart';
import '../../../domain/usecases/expense/add_expense.dart';
import '../../../domain/usecases/expense/delete_expense.dart';
import '../../../domain/usecases/expense/get_weekly_expenses.dart';
import '../../../core/usecase/usecase.dart';

// Events
abstract class ExpenseEvent extends Equatable {
  const ExpenseEvent();

  @override
  List<Object?> get props => [];
}

class LoadExpenses extends ExpenseEvent {
  const LoadExpenses();
}

class AddNewExpense extends ExpenseEvent {
  final Expense expense;

  const AddNewExpense(this.expense);

  @override
  List<Object?> get props => [expense];
}

class DeleteExpenseEvent extends ExpenseEvent {
  final String id;

  const DeleteExpenseEvent(this.id);

  @override
  List<Object?> get props => [id];
}

class RefreshData extends ExpenseEvent {
  const RefreshData();
}

// States
abstract class ExpenseState extends Equatable {
  const ExpenseState();

  @override
  List<Object?> get props => [];
}

class ExpenseInitial extends ExpenseState {
  const ExpenseInitial();
}

class ExpenseLoading extends ExpenseState {
  const ExpenseLoading();
}

class ExpenseLoaded extends ExpenseState {
  final List<Expense> expenses;
  final Map<DateTime, double> weeklyData;
  final double totalToday;
  final double totalWeek;

  const ExpenseLoaded({
    required this.expenses,
    required this.weeklyData,
    required this.totalToday,
    required this.totalWeek,
  });

  @override
  List<Object?> get props => [expenses, weeklyData, totalToday, totalWeek];
}

class ExpenseError extends ExpenseState {
  final String message;

  const ExpenseError(this.message);

  @override
  List<Object?> get props => [message];
}

// BLoC
class ExpenseBloc extends Bloc<ExpenseEvent, ExpenseState> {
  final GetAllExpenses getAllExpenses;
  final AddExpense addExpense;
  final DeleteExpense deleteExpense;
  final GetWeeklyExpenses getWeeklyExpenses;

  ExpenseBloc({
    required this.getAllExpenses,
    required this.addExpense,
    required this.deleteExpense,
    required this.getWeeklyExpenses,
  }) : super(const ExpenseInitial()) {
    on<LoadExpenses>(_onLoadExpenses);
    on<AddNewExpense>(_onAddExpense);
    on<DeleteExpenseEvent>(_onDeleteExpense);
    on<RefreshData>(_onRefreshData);
  }

  Future<void> _onLoadExpenses(LoadExpenses event, Emitter<ExpenseState> emit) async {
    emit(const ExpenseLoading());

    final expensesResult = await getAllExpenses(NoParams());
    final weeklyResult = await getWeeklyExpenses(NoParams());

    expensesResult.fold(
      (failure) => emit(ExpenseError(failure.message)),
      (expenses) async {
        weeklyResult.fold(
          (failure) => emit(ExpenseError(failure.message)),
          (weeklyData) {
            // Hitung total hari ini
            final now = DateTime.now();
            final todayExpenses = expenses.where((e) =>
                e.date.year == now.year &&
                e.date.month == now.month &&
                e.date.day == now.day
            ).toList();
            
            final totalToday = todayExpenses.fold(0.0, (sum, e) => sum + e.amount);
            
            // Hitung total minggu ini (7 hari terakhir)
            final totalWeek = weeklyData.values.fold(0.0, (sum, amount) => sum + amount);

            emit(ExpenseLoaded(
              expenses: expenses,
              weeklyData: weeklyData,
              totalToday: totalToday,
              totalWeek: totalWeek,
            ));
          },
        );
      },
    );
  }

  Future<void> _onAddExpense(AddNewExpense event, Emitter<ExpenseState> emit) async {
    final result = await addExpense(AddExpenseParams(expense: event.expense));

    result.fold(
      (failure) => emit(ExpenseError(failure.message)),
      (_) {
        add(const LoadExpenses()); // Reload data
      },
    );
  }

  Future<void> _onDeleteExpense(DeleteExpenseEvent event, Emitter<ExpenseState> emit) async {
    final result = await deleteExpense(DeleteExpenseParams(id: event.id));

    result.fold(
      (failure) => emit(ExpenseError(failure.message)),
      (_) {
        add(const LoadExpenses()); // Reload data
      },
    );
  }

  Future<void> _onRefreshData(RefreshData event, Emitter<ExpenseState> emit) async {
    add(const LoadExpenses());
  }
}
