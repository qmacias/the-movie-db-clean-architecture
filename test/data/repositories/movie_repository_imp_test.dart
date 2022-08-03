import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:the_movies_db_clean_architecture/core/errors/exceptions.dart';
import 'package:the_movies_db_clean_architecture/core/errors/failures.dart';
import 'package:the_movies_db_clean_architecture/data/datasources/movie_datasource.dart';
import 'package:the_movies_db_clean_architecture/data/models/movie_model.dart';
import 'package:the_movies_db_clean_architecture/data/repositories/movie_repository_imp.dart';
import 'package:the_movies_db_clean_architecture/domain/repositories/movie_repository.dart';

class MockMovieDatasource extends Mock implements MovieDatasource {}

void main() {
  late MovieRepository movieRepositoryImp;
  late MovieDatasource movieDatasource;

  setUp(() {
    movieDatasource = MockMovieDatasource();
    movieRepositoryImp = MovieRepositoryImp(movieDatasource: movieDatasource);
  });

  group('MovieRepositoryImp PopularMovies', () {
    test('should be the same instance of MovieRepositoryImp', () {
      expect(movieRepositoryImp, isA<MovieRepository>());
    });

    test('should return a list of model movies when calls the datasource',
        () async {
      final movies = [
        const MovieModel(
          title: 'title',
          posterPath: 'posterPath',
          releaseDate: 'releaseDate',
          voteAverage: 1,
        ),
      ];

      when(movieDatasource.getPopularMovies).thenAnswer((_) async => movies);
      final result = await movieRepositoryImp.getPopularMovies(0);
      expect(result, Right(movies));
    });

    test(
        'should return a server failure when calls the datasource is unsuccessful',
        () async {
      when(movieDatasource.getPopularMovies).thenThrow(const ServerException());
      final result = await movieRepositoryImp.getPopularMovies(0);
      expect(result, Left(ServerFailure()));
    });

    test(
        'should return a notFoundFailure when calls the datasource is unsuccessful',
        () async {
      when(movieDatasource.getPopularMovies)
          .thenThrow(const NotFoundException());
      final result = await movieRepositoryImp.getPopularMovies(0);
      expect(result, Left(NotFoundFailure()));
    });
  });

  group("MovieRepositoryImp TrendingMovies |", () {
    test("should return a list of model movies when calls the datasource",
        () async {
      final movies = [
        const MovieModel(
          title: 'title',
          posterPath: 'posterPath',
          releaseDate: 'releaseDate',
          voteAverage: 1,
        ),
      ];
      when(movieDatasource.getTrendingMovies).thenAnswer((_) async => movies);
      final result = await movieRepositoryImp.getTrendingMovies(0);
      expect(result, Right(movies));
    });

    test(
        "should return a server failure when calls the datasource is unsuccessful",
        () async {
      when(movieDatasource.getTrendingMovies)
          .thenThrow(const ServerException());
      final result = await movieRepositoryImp.getTrendingMovies(0);
      expect(result, Left(ServerFailure()));
    });

    test(
        'should return a notFoundFailure when calls the datasource is unsuccessful',
        () async {
      when(movieDatasource.getTrendingMovies)
          .thenThrow(const NotFoundException());
      final result = await movieRepositoryImp.getTrendingMovies(0);
      expect(result, Left(NotFoundFailure()));
    });
  });
}
