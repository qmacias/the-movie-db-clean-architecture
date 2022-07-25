part of 'movie_bloc.dart';

abstract class MovieEvent extends Equatable {
  const MovieEvent();

  @override
  List<Object> get props => [];
}

class PopularMoviesLoadEvent extends MovieEvent {
  const PopularMoviesLoadEvent();

  @override
  List<Object> get props => [];
}

class TrendingMoviesLoadEvent extends MovieEvent {
  const TrendingMoviesLoadEvent();

  @override
  List<Object> get props => [];
}
