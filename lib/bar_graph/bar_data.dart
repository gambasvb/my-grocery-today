import 'individual_bar.dart';

/// Menyimpan data untuk setiap hari dalam grafik batang.
class BarData {
  final double _sunAmount;
  final double _monAmount;
  final double _tueAmount;
  final double _wedAmount;
  final double _thuAmount;
  final double _friAmount;
  final double _satAmount;

  /// Membuat instance BarData dengan jumlah untuk setiap hari.
  BarData({
    required double sunAmount,
    required double monAmount,
    required double tueAmount,
    required double wedAmount,
    required double thuAmount,
    required double friAmount,
    required double satAmount,
  })  : _sunAmount = sunAmount,
        _monAmount = monAmount,
        _tueAmount = tueAmount,
        _wedAmount = wedAmount,
        _thuAmount = thuAmount,
        _friAmount = friAmount,
        _satAmount = satAmount;

  List<IndividualBar> _barData = [];

  /// Mendapatkan data batang yang telah diinisialisasi.
  List<IndividualBar> get barData => _barData;

  /// Menginisialisasi data batang dengan jumlah untuk setiap hari dalam seminggu.
  void initializeBarData() {
    _barData = [
      IndividualBar(x: 0, y: _sunAmount),
      IndividualBar(x: 1, y: _monAmount),
      IndividualBar(x: 2, y: _tueAmount),
      IndividualBar(x: 3, y: _wedAmount),
      IndividualBar(x: 4, y: _thuAmount),
      IndividualBar(x: 5, y: _friAmount),
      IndividualBar(x: 6, y: _satAmount),
    ];
  }
}
