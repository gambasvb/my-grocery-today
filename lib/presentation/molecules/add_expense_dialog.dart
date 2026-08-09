import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_constants.dart';
import '../../domain/entities/expense.dart';
import '../bloc/expense/expense_bloc.dart';

/// Molecule: Dialog Bottom Sheet untuk menambah pengeluaran
class AddExpenseDialog extends StatefulWidget {
  const AddExpenseDialog({super.key});

  @override
  State<AddExpenseDialog> createState() => _AddExpenseDialogState();
}

class _AddExpenseDialogState extends State<AddExpenseDialog> {
  final _formKey = GlobalKey<FormState>();
  final _descriptionController = TextEditingController();
  final _amountController = TextEditingController();
  final _noteController = TextEditingController();
  
  String _selectedCategoryId = 'makanan'; // Default category
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();

  final List<Map<String, dynamic>> _categories = [
    {'id': 'makanan', 'name': 'Makanan', 'icon': '🍔', 'color': AppColors.primary},
    {'id': 'transportasi', 'name': 'Transportasi', 'icon': '🚗', 'color': AppColors.secondary},
    {'id': 'belanja', 'name': 'Belanja', 'icon': '🛒', 'color': AppColors.success},
    {'id': 'hiburan', 'name': 'Hiburan', 'icon': '🎬', 'color': AppColors.warning},
    {'id': 'kesehatan', 'name': 'Kesehatan', 'icon': '💊', 'color': AppColors.info},
    {'id': 'lainnya', 'name': 'Lainnya', 'icon': '📦', 'color': AppColors.textSecondary},
  ];

  @override
  void dispose() {
    _descriptionController.dispose();
    _amountController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppConstants.radiusXL),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(AppConstants.spacingL),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Handle bar
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      margin: const EdgeInsets.only(bottom: AppConstants.spacingL),
                      decoration: BoxDecoration(
                        color: AppColors.surfaceVariant,
                        borderRadius: BorderRadius.circular(AppConstants.radiusFull),
                      ),
                    ),
                  ),
                  
                  // Title
                  const Text(
                    'Tambah Pengeluaran',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  
                  const SizedBox(height: AppConstants.spacingL),
                  
                  // Amount Input
                  TextFormField(
                    controller: _amountController,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.right,
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                    decoration: InputDecoration(
                      labelText: 'Jumlah',
                      prefixText: 'Rp ',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppConstants.radiusMD),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Masukkan jumlah pengeluaran';
                      }
                      if (double.tryParse(value) == null) {
                        return 'Format jumlah tidak valid';
                      }
                      return null;
                    },
                  ),
                  
                  const SizedBox(height: AppConstants.spacingM),
                  
                  // Description Input
                  TextFormField(
                    controller: _descriptionController,
                    decoration: InputDecoration(
                      labelText: 'Deskripsi',
                      hintText: 'Contoh: Makan siang',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppConstants.radiusMD),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Masukkan deskripsi';
                      }
                      return null;
                    },
                  ),
                  
                  const SizedBox(height: AppConstants.spacingM),
                  
                  // Category Selection
                  const Text(
                    'Kategori',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  
                  const SizedBox(height: AppConstants.spacingS),
                  
                  Wrap(
                    spacing: AppConstants.spacingS,
                    runSpacing: AppConstants.spacingS,
                    children: _categories.map((category) {
                      final isSelected = _selectedCategoryId == category['id'];
                      return ChoiceChip(
                        label: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(category['icon']),
                            const SizedBox(width: 4),
                            Text(category['name']),
                          ],
                        ),
                        selected: isSelected,
                        onSelected: (selected) {
                          setState(() {
                            _selectedCategoryId = category['id'];
                          });
                        },
                        selectedColor: category['color'].withOpacity(0.2),
                        checkmarkColor: category['color'],
                        labelStyle: TextStyle(
                          color: isSelected ? category['color'] : AppColors.textSecondary,
                          fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                        ),
                      );
                    }).toList(),
                  ),
                  
                  const SizedBox(height: AppConstants.spacingM),
                  
                  // Date & Time Pickers
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: _selectDate,
                          icon: const Icon(Icons.calendar_today, size: 18),
                          label: Text(
                            DateFormat('dd MMM yyyy', 'id_ID').format(_selectedDate),
                          ),
                          style: OutlinedButton.styleFrom(
                            alignment: Alignment.centerLeft,
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppConstants.spacingM,
                              vertical: AppConstants.spacingM,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: AppConstants.spacingM),
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: _selectTime,
                          icon: const Icon(Icons.access_time, size: 18),
                          label: Text(
                            _selectedTime.format(context),
                          ),
                          style: OutlinedButton.styleFrom(
                            alignment: Alignment.centerLeft,
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppConstants.spacingM,
                              vertical: AppConstants.spacingM,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: AppConstants.spacingM),
                  
                  // Note Input (Optional)
                  TextFormField(
                    controller: _noteController,
                    maxLines: 2,
                    decoration: InputDecoration(
                      labelText: 'Catatan (Opsional)',
                      hintText: 'Tambahkan catatan jika perlu',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppConstants.radiusMD),
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: AppConstants.spacingL),
                  
                  // Submit Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _submitExpense,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          vertical: AppConstants.spacingM,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppConstants.radiusMD),
                        ),
                      ),
                      child: const Text(
                        'Simpan Pengeluaran',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
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

  Future<void> _selectDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime.now().add(const Duration(days: 1)),
      locale: const Locale('id', 'ID'),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (picked != null) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  void _submitExpense() {
    if (_formKey.currentState!.validate()) {
      final amount = double.parse(_amountController.text);
      final combinedDateTime = DateTime(
        _selectedDate.year,
        _selectedDate.month,
        _selectedDate.day,
        _selectedTime.hour,
        _selectedTime.minute,
      );

      final expense = Expense(
        id: const Uuid().v4(),
        amount: amount,
        description: _descriptionController.text.trim(),
        date: combinedDateTime,
        categoryId: _selectedCategoryId,
        note: _noteController.text.trim().isEmpty ? null : _noteController.text.trim(),
      );

      context.read<ExpenseBloc>().add(AddNewExpense(expense));
      Navigator.pop(context);
      
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Pengeluaran berhasil ditambahkan'),
          backgroundColor: AppColors.success,
        ),
      );
    }
  }
}
