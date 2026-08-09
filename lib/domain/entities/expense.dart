import 'package:equatable/equatable.dart';

/// Entitas Pengeluaran
/// Merepresentasikan data pengeluaran dalam domain bisnis
class Expense extends BaseEntity {
  final double amount;
  final String description;
  final DateTime date;
  final String categoryId;
  final String? note;

  const Expense({
    required String id,
    required this.amount,
    required this.description,
    required this.date,
    required this.categoryId,
    this.note,
  }) : super(id: id);

  /// Mengembalikan nama hari dalam bahasa Indonesia
  String get dayName {
    const days = ['Min', 'Sen', 'Sel', 'Rab', 'Kam', 'Jum', 'Sab'];
    return days[date.weekday % 7];
  }

  /// Format tanggal lengkap dalam bahasa Indonesia
  String get formattedDate {
    const months = [
      'Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni',
      'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember'
    ];
    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }

  /// Format waktu (jam:menit)
  String get formattedTime {
    return '${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
  }

  @override
  List<Object?> get props => [
        id,
        amount,
        description,
        date,
        categoryId,
        note,
      ];

  /// Copy dengan perubahan tertentu
  Expense copyWith({
    String? id,
    double? amount,
    String? description,
    DateTime? date,
    String? categoryId,
    String? note,
  }) {
    return Expense(
      id: id ?? this.id,
      amount: amount ?? this.amount,
      description: description ?? this.description,
      date: date ?? this.date,
      categoryId: categoryId ?? this.categoryId,
      note: note ?? this.note,
    );
  }
}
