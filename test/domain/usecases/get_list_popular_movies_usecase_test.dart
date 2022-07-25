import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:the_movies_db_clean_architecture/core/errors/failures.dart';
import 'package:the_movies_db_clean_architecture/core/usecase/usecase.dart';
import 'package:the_movies_db_clean_architecture/domain/entities/movie_entity.dart';
import 'package:the_movies_db_clean_architecture/domain/repositories/movie_repository.dart';
import 'package:the_movies_db_clean_architecture/domain/usecases/get_list_popular_movies_usecase.dart';

class MockMovieRepository extends Mock implements MovieRepository {}

void main() {
  late GetPopularMoviesUseCase useCase;
  late MovieRepository repository;

  setUp(() {
    repository = MockMovieRepository();
    useCase = GetPopularMoviesUseCase(repository: repository);
  });

  group("GetMoviesPopular |", () {
    test('should get popular movies', () async {
      //population list_movies
      final movies = [
        const MovieEntity(
          title: 'title',
          posterPath: 'posterPath',
          releaseDate: 'releaseDate',
          voteAverage: 1,
        )
      ];
      //listen to calls in the repository ↓↓↓
      //when the repository is called at some point side Right is the expected result
      when(repository.getPopularMovies).thenAnswer((_) async => Right(movies));
      //do the call to the usecase ↓↓↓
      final result = await useCase(NoParams());
      //verify the result ↓↓↓
      expect(result, Right(movies));
      verify(repository.getPopularMovies);
      verifyNoMoreInteractions(repository);
    });

    test('should return server error', () async {
      when(repository.getPopularMovies)
          .thenAnswer((_) async => Left(ServerFailure()));
      final result = await useCase(NoParams());
      expect(result, Left(ServerFailure()));
      verify(repository.getPopularMovies);
      verifyNoMoreInteractions(repository);
    });
    test("should retun a notFoundError", () async {
      when(repository.getPopularMovies)
          .thenAnswer((_) async => Left(NotFoundFailure()));
      final result = await useCase(NoParams());
      expect(result, Left(NotFoundFailure()));
      verify(repository.getPopularMovies);
      verifyNoMoreInteractions(repository);
    });
  });
}
