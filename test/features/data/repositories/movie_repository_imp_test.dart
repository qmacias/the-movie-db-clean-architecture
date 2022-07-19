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

  group('MovieRepositoryImp', () {
    test('should be the same instance of MovieRepositoryImp', () {
      expect(movieRepositoryImp, isA<MovieRepositoryImp>());
    });

    test('should return a list of model movies when calls the datasource',
        () async {
      // arrange
      final movies = [
        const MovieModel(
          title: 'title',
          posterPath: 'posterPath',
          releaseDate: 'releaseDate',
          voteAverage: 1,
        ),
      ];

      when(movieDatasource.getListPopularMovies)
          .thenAnswer((_) async => movies);
      // act
      final result = await movieRepositoryImp.getListPopularMovies();
      // assert
      expect(result, Right(movies));
    });

    test(
        'should return a server failure when calls the datasource is unsuccessful',
        () async {
      // arrange
      when(movieDatasource.getListPopularMovies)
          .thenThrow(const ServerException());
      // act
      final result = await movieRepositoryImp.getListPopularMovies();
      // assert
      expect(result, Left(ServerFailure()));
      verify(movieDatasource.getListPopularMovies);
    });
  });
}
