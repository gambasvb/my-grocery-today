import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_constants.dart';
import '../../domain/entities/expense.dart';
import '../bloc/expense/expense_bloc.dart';

/// Organism: Daftar Pengeluaran dengan swipe-to-delete
class ExpenseList extends StatelessWidget {
  final List<Expense> expenses;

  const ExpenseList({
    super.key,
    required this.expenses,
  });

  @override
  Widget build(BuildContext context) {
    if (expenses.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(AppConstants.spacingL),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppConstants.radiusLG),
        ),
        child: Column(
          children: [
            Icon(
              Icons.receipt_long_outlined,
              size: 48,
              color: AppColors.textHint,
            ),
            const SizedBox(height: AppConstants.spacingM),
            Text(
              'Belum ada pengeluaran',
              style: TextStyle(
                fontSize: 16,
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: AppConstants.spacingS),
            Text(
              'Mulai catat pengeluaranmu hari ini',
              style: TextStyle(
                fontSize: 14,
                color: AppColors.textHint,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: expenses.length,
      separatorBuilder: (_, __) => const SizedBox(height: AppConstants.spacingS),
      itemBuilder: (context, index) {
        final expense = expenses[index];
        return _buildExpenseCard(context, expense);
      },
    );
  }

  Widget _buildExpenseCard(BuildContext context, Expense expense) {
    final currencyFormat = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    );

    return Dismissible(
      key: Key(expense.id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: AppConstants.spacingM),
        decoration: BoxDecoration(
          color: AppColors.error.withOpacity(0.1),
          borderRadius: BorderRadius.circular(AppConstants.radiusLG),
        ),
        child: const Icon(
          Icons.delete_outline,
          color: AppColors.error,
        ),
      ),
      confirmDismiss: (direction) async {
        return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Hapus Pengeluaran'),
            content: const Text('Apakah Anda yakin ingin menghapus pengeluaran ini?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('Batal'),
              ),
              ElevatedButton(
                onPressed: () => Navigator.pop(context, true),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.error,
                ),
                child: const Text('Hapus'),
              ),
            ],
          ),
        );
      },
      onDismissed: (direction) {
        context.read<ExpenseBloc>().add(DeleteExpenseEvent(expense.id));
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Pengeluaran dihapus'),
            action: SnackBarAction(
              label: 'Urungkan',
              onPressed: () {
                // TODO: Implement undo functionality
                context.read<ExpenseBloc>().add(const LoadExpenses());
              },
            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(AppConstants.spacingM),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppConstants.radiusLG),
          boxShadow: AppConstants.shadowSM,
        ),
        child: Row(
          children: [
            // Icon Category
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(AppConstants.radiusMD),
              ),
              child: const Icon(
                Icons.shopping_bag_outlined,
                color: AppColors.primary,
                size: 24,
              ),
            ),
            
            const SizedBox(width: AppConstants.spacingM),
            
            // Description & Date
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    expense.description,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${expense.formattedDate} • ${expense.formattedTime}',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.textHint,
                    ),
                  ),
                ],
              ),
            ),
            
            // Amount
            Text(
              currencyFormat.format(expense.amount),
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
