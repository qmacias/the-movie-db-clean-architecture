import 'package:dartz/dartz.dart';
import 'package:the_movies_db_clean_architecture/core/errors/failures.dart';
import 'package:the_movies_db_clean_architecture/core/usecase/usecase.dart';
import 'package:the_movies_db_clean_architecture/domain/entities/movie_entity.dart';
import 'package:the_movies_db_clean_architecture/domain/repositories/movie_repository.dart';

class GetPopularMoviesUseCase implements UseCase<List<MovieEntity>, NoParams> {
  final MovieRepository repository;

  GetPopularMoviesUseCase({required this.repository});

  @override
  Future<Either<Failure, List<MovieEntity>>> call(NoParams params) async {
    return await repository.getPopularMovies();
  }
}
