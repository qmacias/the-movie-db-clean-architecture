part of 'movie_bloc.dart';

abstract class MovieState extends Equatable {
  const MovieState();

  @override
  List<Object> get props => [];
}

class MovieLoadingState extends MovieState {
  final bool isLoading;
  const MovieLoadingState({required this.isLoading});
}

class PopularMoviesLoadedState extends MovieState {
  final List<MovieEntity> listPopularMovies;
  const PopularMoviesLoadedState({required this.listPopularMovies});
  @override
  List<Object> get props => [listPopularMovies];
}

class TrendingMoviesLoadedState extends MovieState {
  final List<MovieEntity> listTrendingMovies;
  const TrendingMoviesLoadedState({required this.listTrendingMovies});
  @override
  List<Object> get props => [listTrendingMovies];
}

class MoviesErrorState extends MovieState {
  final String message;
  const MoviesErrorState({required this.message});
  @override
  List<Object> get props => [message];
}
