import 'package:equatable/equatable.dart';

/// Entitas Kategori Pengeluaran
class Category extends BaseEntity {
  final String name;
  final String icon;
  final int colorValue; // Menyimpan sebagai int untuk serialisasi

  const Category({
    required String id,
    required this.name,
    required this.icon,
    required this.colorValue,
  }) : super(id: id);

  @override
  List<Object?> get props => [id, name, icon, colorValue];

  /// Copy dengan perubahan tertentu
  Category copyWith({
    String? id,
    String? name,
    String? icon,
    int? colorValue,
  }) {
    return Category(
      id: id ?? this.id,
      name: name ?? this.name,
      icon: icon ?? this.icon,
      colorValue: colorValue ?? this.colorValue,
    );
  }
}
