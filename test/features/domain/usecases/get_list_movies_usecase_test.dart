import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:the_movies_db_clean_architecture/core/usecase/usecase.dart';
import 'package:the_movies_db_clean_architecture/features/domain/entities/movie_entity.dart';
import 'package:the_movies_db_clean_architecture/features/domain/repositories/movie_repository.dart';
import 'package:the_movies_db_clean_architecture/features/domain/usecases/get_list_movies_popular_usecase.dart';

class MockMovieRepository extends Mock implements MovieRepository {}

void main() {
  late GetListMoviesPopularUseCase useCase;
  late MovieRepository repository;

  setUp(() {
    repository = MockMovieRepository();
    useCase = GetListMoviesPopularUseCase(repository);
  });

  test('should get popular movies', () async {
    //population list_movies
    final movies = [
      MovieEntity(
        title: 'title',
        posterPath: 'posterPath',
        releaseDate: 'releaseDate',
        voteAverage: 1,
      )
    ];
    //listen to calls in the repository ↓↓↓
    //when the repository is called at some point side Right is the expected result
    when(repository.getListPopularMovies)
        .thenAnswer((_) async => Right(movies));
    //do the call to the usecase ↓↓↓
    final result = await useCase(NoParams());
    //verify the result ↓↓↓
    expect(result, Right(movies));
    verify(repository.getListPopularMovies);
    verifyNoMoreInteractions(repository);
  });
}
