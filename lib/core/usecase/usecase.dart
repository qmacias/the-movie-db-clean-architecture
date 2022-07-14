import 'package:dartz/dartz.dart';
import 'package:the_movies_db_clean_architecture/core/errors/failures.dart';

abstract class UseCase<Type, NoParams> {
  Future<Either<Failure, Type>> call(NoParams params);
}

class NoParams {}
