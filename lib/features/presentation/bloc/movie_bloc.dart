import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:the_movies_db_clean_architecture/core/usecase/usecase.dart';
import 'package:the_movies_db_clean_architecture/domain/entities/movie_entity.dart';
import 'package:the_movies_db_clean_architecture/domain/usecases/get_list_movies_popular_usecase.dart';
import 'package:the_movies_db_clean_architecture/domain/usecases/get_list_movies_trending_usecase.dart';

part 'movie_event.dart';
part 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final GetListMoviesPopularUseCase getListMoviesPopularUseCase;
  final GetListMoviesTrendingUsecase getListMoviesTrendingUsecase;

  MovieBloc({
    required this.getListMoviesPopularUseCase,
    required this.getListMoviesTrendingUsecase,
  }) : super(const MovieLoadingState(isLoading: true)) {
    on<PopularMoviesLoadEvent>((event, emit) async {
      //display circularProgress while making api call
      emit(const MovieLoadingState(isLoading: true));
      //call my userCases
      final failureOrSucess = await getListMoviesPopularUseCase(NoParams());

      //verify if the call was successful
      //if my userCases return success, display the data
      emit(const MovieLoadingState(isLoading: false));
      emit(
        failureOrSucess.fold(
            (failure) =>
                const MoviesErrorState(message: "Ops! Something went wrong"),
            (movies) => PopularMoviesLoadedState(listPopularMovies: movies)),
      );
    });
    on<TrendingMoviesLoadEvent>((event, emit) async {
      emit(const MovieLoadingState(isLoading: true));

      final failureOrSucess = await getListMoviesTrendingUsecase(NoParams());
      emit(const MovieLoadingState(isLoading: false));
      emit(
        failureOrSucess.fold(
            (failure) =>
                const MoviesErrorState(message: "Ops! Something went wrong"),
            (movies) => TrendingMoviesLoadedState(listTrendingMovies: movies)),
      );
    });
  }
}
