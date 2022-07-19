part of 'movie_bloc.dart';

abstract class MovieEvent extends Equatable {
  const MovieEvent();

  @override
  List<Object> get props => [];
}

class PopularMoviesLoadEvent extends MovieEvent {
  final List<MovieEntity> listPopularMovies;
  const PopularMoviesLoadEvent({required this.listPopularMovies});

  @override
  List<Object> get props => [listPopularMovies];
}

class TrendingMoviesLoadEvent extends MovieEvent {
  final List<MovieEntity> listTrendingMovies;
  const TrendingMoviesLoadEvent({required this.listTrendingMovies});

  @override
  List<Object> get props => [listTrendingMovies];
}
