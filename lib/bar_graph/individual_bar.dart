/// Merepresentasikan satu batang dalam grafik dengan koordinat x dan y.
class IndividualBar {
  final int _x;
  final double _y;

  /// Membuat instance IndividualBar dengan posisi x dan tinggi y.
  IndividualBar({
    required int x,
    required double y,
  })  : _x = x,
        _y = y;

  /// Mendapatkan posisi x batang.
  int get x => _x;

  /// Mendapatkan tinggi batang (nilai y).
  double get y => _y;
}
