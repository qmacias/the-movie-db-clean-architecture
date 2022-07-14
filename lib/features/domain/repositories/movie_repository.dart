import 'package:dartz/dartz.dart';
import 'package:the_movies_db_clean_architecture/core/errors/failures.dart';
import 'package:the_movies_db_clean_architecture/features/domain/entities/movie_entity.dart';

abstract class MovieRepository {
  Future<Either<Failure, List<MovieEntity>>> getListMoviesPopular();
  Future<Either<Failure, List<MovieEntity>>> getListMoviesTrending();
}
