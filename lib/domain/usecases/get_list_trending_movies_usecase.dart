import 'package:dartz/dartz.dart';
import 'package:the_movies_db_clean_architecture/core/errors/failures.dart';
import 'package:the_movies_db_clean_architecture/core/usecase/usecase.dart';
import 'package:the_movies_db_clean_architecture/domain/entities/movie_entity.dart';
import 'package:the_movies_db_clean_architecture/domain/repositories/movie_repository.dart';

class GetTrendingMoviesUsecase implements UseCase<List<MovieEntity>, int> {
  GetTrendingMoviesUsecase({required this.repository});

  final MovieRepository repository;

  @override
  Future<Either<Failure, List<MovieEntity>>> call(int page) async {
    return await repository.getTrendingMovies(page);
  }
}
