import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:the_movies_db_clean_architecture/core/errors/failures.dart';
import 'package:the_movies_db_clean_architecture/core/usecase/usecase.dart';
import 'package:the_movies_db_clean_architecture/domain/entities/movie_entity.dart';
import 'package:the_movies_db_clean_architecture/domain/repositories/movie_repository.dart';
import 'package:the_movies_db_clean_architecture/domain/usecases/get_list_trending_movies_usecase.dart';

class MockMovieRepository extends Mock implements MovieRepository {}

void main() {
  late GetListTrendingMoviesUsecase usecase;
  late MovieRepository repository;

  setUp(() {
    repository = MockMovieRepository();
    usecase = GetListTrendingMoviesUsecase(repository: repository);
  });

  group("GetMoviesTrending |", () {
    test("should get trending movies", () async {
      final movies = [
        const MovieEntity(
          title: 'title',
          posterPath: 'posterPath',
          releaseDate: 'releaseDate',
          voteAverage: 1,
        )
      ];
      when(repository.getListTrendingMovies)
          .thenAnswer((_) async => Right(movies));
      final result = await usecase(NoParams());
      expect(result, Right(movies));
      verify(repository.getListTrendingMovies);
      verifyNoMoreInteractions(repository);
    });

    test("should return server error", () async {
      when(repository.getListTrendingMovies)
          .thenAnswer((_) async => Left(ServerFailure()));
      final result = await usecase(NoParams());
      expect(result, Left(ServerFailure()));
      verify(repository.getListTrendingMovies);
      verifyNoMoreInteractions(repository);
    });

    test("should retun a notFoundError", () async {
      when(repository.getListTrendingMovies)
          .thenAnswer((_) async => Left(NotFoundFailure()));
      final result = await usecase(NoParams());
      expect(result, Left(NotFoundFailure()));
      verify(repository.getListTrendingMovies);
      verifyNoMoreInteractions(repository);
    });
  });
}
