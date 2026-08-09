import 'package:equatable/equatable.dart';

/// Base Failure class untuk menangani error di domain layer
abstract class Failure extends Equatable {
  final String message;
  final int? code;

  const Failure({required this.message, this.code});

  @override
  List<Object?> get props => [message, code];
}

/// Failure untuk operasi yang tidak ditemukan
class NotFoundFailure extends Failure {
  const NotFoundFailure({String message = 'Data tidak ditemukan'}) 
      : super(message: message, code: 404);
}

/// Failure untuk validasi input yang gagal
class ValidationFailure extends Failure {
  const ValidationFailure({String message = 'Validasi gagal'}) 
      : super(message: message, code: 400);
}

/// Failure untuk error database
class DatabaseFailure extends Failure {
  const DatabaseFailure({String message = 'Error database'}) 
      : super(message: message, code: 500);
}

/// Failure untuk error umum
class GeneralFailure extends Failure {
  const GeneralFailure({String message = 'Terjadi kesalahan', int code = 500}) 
      : super(message: message, code: code);
}
