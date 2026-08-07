/// Mengkonversi DateTime ke string dengan format YYYYMMDD.
/// 
/// [dateTime] adalah DateTime yang akan dikonversi.
/// Mengembalikan string dalam format tahun, bulan, dan hari tanpa separator.
String convertDateTimeToString(DateTime dateTime) {
  final year = dateTime.year.toString();
  final month = dateTime.month.toString().padLeft(2, '0');
  final day = dateTime.day.toString().padLeft(2, '0');
  return '$year$month$day';
}
