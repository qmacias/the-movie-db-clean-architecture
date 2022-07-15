import 'package:dartz/dartz.dart';
import 'package:the_movies_db_clean_architecture/core/errors/exceptions.dart';
import 'package:the_movies_db_clean_architecture/core/errors/failures.dart';
import 'package:the_movies_db_clean_architecture/features/data/datasources/movie_datasource.dart';
import 'package:the_movies_db_clean_architecture/features/domain/entities/movie_entity.dart';
import 'package:the_movies_db_clean_architecture/features/domain/repositories/movie_repository.dart';

class MovieRepositoryImp implements MovieRepository {
  final MovieDatasource movieDatasource;

  MovieRepositoryImp(this.movieDatasource);
  @override
  Future<Either<Failure, List<MovieEntity>>> getListPopularMovies() async {
    try {
      final result = await movieDatasource.getListPopularMovies();
      return Right(result);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<MovieEntity>>> getListTrendingMovies() async {
    try {
      final result = await movieDatasource.getListTrendingMovies();
      return Right(result);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}