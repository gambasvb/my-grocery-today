/// Merepresentasikan item pengeluaran dengan nama, jumlah, dan tanggal.
class ExpenseItem {
  final String _name;
  final double _amount;
  final DateTime _dateTime;

  /// Membuat instance baru dari ExpenseItem.
  /// 
  /// [name] adalah nama pengeluaran.
  /// [amount] adalah jumlah pengeluaran dalam bentuk double.
  /// [dateTime] adalah waktu ketika pengeluaran dicatat.
  ExpenseItem({
    required String name,
    required double amount,
    required DateTime dateTime,
  })  : _name = name,
        _amount = amount,
        _dateTime = dateTime;

  /// Mendapatkan nama pengeluaran.
  String get name => _name;

  /// Mendapatkan jumlah pengeluaran.
  double get amount => _amount;

  /// Mendapatkan waktu pencatatan pengeluaran.
  DateTime get dateTime => _dateTime;

  @override
  String toString() =>
      'ExpenseItem(nama: $_name, jumlah: $_amount, tanggal: $_dateTime)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExpenseItem &&
          runtimeType == other.runtimeType &&
          _name == other._name &&
          _amount == other._amount &&
          _dateTime == other._dateTime;

  @override
  int get hashCode => _name.hashCode ^ _amount.hashCode ^ _dateTime.hashCode;
}
