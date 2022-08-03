part of 'movie_bloc.dart';

abstract class MovieEvent extends Equatable {
  const MovieEvent();

  @override
  List<Object> get props => [];
}

class PopularMoviesLoadEvent extends MovieEvent {
  final int page;

  const PopularMoviesLoadEvent({required this.page});
  @override
  List<Object> get props => [];
}

class TrendingMoviesLoadEvent extends MovieEvent {
  const TrendingMoviesLoadEvent();

  @override
  List<Object> get props => [];
}
