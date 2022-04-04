import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:sparkz/core/failure/failure.dart';

abstract class UserCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}
