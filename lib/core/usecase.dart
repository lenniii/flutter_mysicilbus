import 'package:dartz/dartz.dart';
import 'package:sicilbus_clean_arch/core/errors/failures.dart';

abstract class UseCase<Type, Parameters> {
  Future<Either<Failure, Type>> call(Parameters parameters);
}
