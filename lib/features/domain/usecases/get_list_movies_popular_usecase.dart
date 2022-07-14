import 'package:dartz/dartz.dart';
import 'package:the_movies_db_clean_architecture/core/errors/failures.dart';
import 'package:the_movies_db_clean_architecture/core/usecase/usecase.dart';
import 'package:the_movies_db_clean_architecture/features/domain/entities/movie_entity.dart';
import 'package:the_movies_db_clean_architecture/features/domain/repositories/movie_repository.dart';

class GetListMoviesPopularUseCase
    implements UseCase<List<MovieEntity>, NoParams> {
  final MovieRepository repository;

  GetListMoviesPopularUseCase(this.repository);

  @override
  Future<Either<Failure, List<MovieEntity>>> call(NoParams params) async {
    return await repository.getListMoviesPopular();
  }
}
