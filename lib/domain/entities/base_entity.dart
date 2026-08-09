import 'package:equatable/equatable.dart';

/// Entity dasar untuk semua entitas domain
abstract class BaseEntity extends Equatable {
  final String id;

  const BaseEntity({required this.id});

  @override
  List<Object?> get props => [id];
}
