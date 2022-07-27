import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:the_movies_db_clean_architecture/core/usecase/usecase.dart';
import 'package:the_movies_db_clean_architecture/domain/entities/movie_entity.dart';
import 'package:the_movies_db_clean_architecture/domain/usecases/get_list_popular_movies_usecase.dart';
import 'package:the_movies_db_clean_architecture/domain/usecases/get_list_trending_movies_usecase.dart';

part 'movie_event.dart';
part 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final GetPopularMoviesUseCase getMoviesPopularUseCase;
  final GetTrendingMoviesUsecase getMoviesTrendingUsecase;

  MovieBloc({
    required this.getMoviesPopularUseCase,
    required this.getMoviesTrendingUsecase,
  }) : super(const PopularMovieLoadingState()) {
    on<PopularMoviesLoadEvent>(_getPopularMovies);
    on<TrendingMoviesLoadEvent>(_getTrendingMovies);
  }

  Future<void> _getPopularMovies(event, emit) async {
    emit(const PopularMovieLoadingState());
    final failureOrSucess = await getMoviesPopularUseCase(NoParams());
    emit(
      failureOrSucess.fold(
          (failure) =>
              const MoviesErrorState(message: "Ops! Something went wrong"),
          (movies) => PopularMoviesLoadedState(listPopularMovies: movies)),
    );
  }

  Future<void> _getTrendingMovies(event, emit) async {
    emit(const TrendingMovieLoadingState());
    final failureOrSucess = await getMoviesTrendingUsecase(NoParams());
    emit(
      failureOrSucess.fold(
          (failure) =>
              const MoviesErrorState(message: "Ops! Something went wrong"),
          (movies) => TrendingMoviesLoadedState(listTrendingMovies: movies)),
    );
  }
}
