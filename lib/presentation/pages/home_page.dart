import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_constants.dart';
import '../../domain/entities/expense.dart';
import '../bloc/expense/expense_bloc.dart';
import '../organisms/expense_list.dart';
import '../organisms/weekly_chart.dart';
import '../organisms/summary_cards.dart';
import '../molecules/add_expense_dialog.dart';

/// Halaman Utama Dashboard
/// Menampilkan ringkasan pengeluaran, grafik mingguan, dan daftar pengeluaran
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: BlocBuilder<ExpenseBloc, ExpenseState>(
        builder: (context, state) {
          if (state is ExpenseLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ExpenseError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.error_outline,
                    size: 64,
                    color: AppColors.error,
                  ),
                  const SizedBox(height: AppConstants.spacingM),
                  Text(
                    state.message,
                    style: const TextStyle(color: AppColors.textSecondary),
                  ),
                  const SizedBox(height: AppConstants.spacingL),
                  ElevatedButton(
                    onPressed: () {
                      context.read<ExpenseBloc>().add(const RefreshData());
                    },
                    child: const Text('Coba Lagi'),
                  ),
                ],
              ),
            );
          } else if (state is ExpenseLoaded) {
            return CustomScrollView(
              slivers: [
                // Sliver App Bar dengan Gradient
                _buildSliverAppBar(state),
                
                // Content
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(AppConstants.spacingM),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Summary Cards
                        SummaryCards(
                          totalToday: state.totalToday,
                          totalWeek: state.totalWeek,
                        ),
                        
                        const SizedBox(height: AppConstants.spacingL),
                        
                        // Weekly Chart
                        WeeklyChart(weeklyData: state.weeklyData),
                        
                        const SizedBox(height: AppConstants.spacingL),
                        
                        // Section Title
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Pengeluaran Terbaru',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                // TODO: Navigate to all expenses page
                              },
                              child: const Text('Lihat Semua'),
                            ),
                          ],
                        ),
                        
                        const SizedBox(height: AppConstants.spacingM),
                        
                        // Expense List
                        ExpenseList(expenses: state.expenses.take(10).toList()),
                        
                        // Spacer untuk FAB
                        const SizedBox(height: 100),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }
          return const SizedBox.shrink();
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddExpenseDialog(context),
        backgroundColor: AppColors.primary,
        icon: const Icon(Icons.add),
        label: const Text('Tambah'),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long_outlined),
            activeIcon: Icon(Icons.receipt_long),
            label: 'Riwayat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.pie_chart_outlined),
            activeIcon: Icon(Icons.pie_chart),
            label: 'Analisis',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            activeIcon: Icon(Icons.settings),
            label: 'Pengaturan',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: AppColors.primary,
        onTap: _onItemTapped,
      ),
    );
  }

  Widget _buildSliverAppBar(ExpenseLoaded state) {
    final now = DateTime.now();
    final dateFormat = DateFormat('EEEE, dd MMMM yyyy', 'id_ID');
    
    return SliverAppBar(
      expandedHeight: 200,
      floating: false,
      pinned: true,
      elevation: 0,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: const BoxDecoration(
            gradient: AppColors.headerGradient,
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(AppConstants.spacingL),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Halo, Selamat Datang! 👋',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white.withOpacity(0.9),
                    ),
                  ),
                  const SizedBox(height: AppConstants.spacingXS),
                  Text(
                    dateFormat.format(now),
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showAddExpenseDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const AddExpenseDialog(),
    );
  }
}
