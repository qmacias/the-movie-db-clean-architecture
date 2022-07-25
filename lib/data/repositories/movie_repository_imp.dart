import 'package:dartz/dartz.dart';
import 'package:the_movies_db_clean_architecture/core/errors/exceptions.dart';
import 'package:the_movies_db_clean_architecture/core/errors/failures.dart';
import 'package:the_movies_db_clean_architecture/data/datasources/movie_datasource.dart';
import 'package:the_movies_db_clean_architecture/domain/entities/movie_entity.dart';
import 'package:the_movies_db_clean_architecture/domain/repositories/movie_repository.dart';

class MovieRepositoryImp implements MovieRepository {
  final MovieDatasource movieDatasource;

  MovieRepositoryImp({required this.movieDatasource});
  @override
  Future<Either<Failure, List<MovieEntity>>> getPopularMovies() async {
    try {
      final result = await movieDatasource.getPopularMovies();
      return Right(result);
    } on ServerException {
      return Left(ServerFailure());
    } on NotFoundException {
      return Left(NotFoundFailure());
    }
  }

  @override
  Future<Either<Failure, List<MovieEntity>>> getTrendingMovies() async {
    try {
      final result = await movieDatasource.getTrendingMovies();
      return Right(result);
    } on ServerException {
      return Left(ServerFailure());
    } on NotFoundException {
      return Left(NotFoundFailure());
    }
  }
}
