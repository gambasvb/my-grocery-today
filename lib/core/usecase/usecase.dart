import 'package:dartz/dartz.dart';
import '../core/failure/failure.dart';

/// Base UseCase untuk operasi tanpa parameter
abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

/// Class kosong untuk use case tanpa parameter
class NoParams {
  const NoParams();
  
  @override
  bool operator ==(Object other) => identical(this, other);
  
  @override
  int get hashCode => 0;
}
