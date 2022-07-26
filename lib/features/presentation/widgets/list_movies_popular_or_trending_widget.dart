import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movies_db_clean_architecture/core/utils/enums/enums.dart';
import 'package:the_movies_db_clean_architecture/features/presentation/bloc/movie_bloc.dart';
import 'package:the_movies_db_clean_architecture/features/presentation/widgets/list_movies_widget.dart';
import 'package:the_movies_db_clean_architecture/features/presentation/widgets/skeleton_movie_widget.dart';
import 'package:the_movies_db_clean_architecture/injection_container.dart';

class ListMoviePopularOrTrendingWidget extends StatelessWidget {
  final MoviesTypeEnum movieTypeEnum;
  const ListMoviePopularOrTrendingWidget(
      {Key? key, required this.movieTypeEnum})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieBloc, MovieState>(
      buildWhen: (previous, current) {
        if (movieTypeEnum == MoviesTypeEnum.popularMovies) {
          return current is PopularMoviesLoadedState;
        } else {
          return current is TrendingMoviesLoadedState;
        }
      },
      builder: (context, state) {
        if (state is PopularMovieLoadingState) {
          return const Center(child: SkeletonMovieWidget());
        }
        if (state is PopularMoviesLoadedState) {
          BlocProvider.of<MovieBloc>(context).add(
            const TrendingMoviesLoadEvent(),
          );
          return ListMovieWidget(
            moviesList: state.listPopularMovies,
          );
        }

        if (state is TrendingMoviesLoadedState) {
          return ListMovieWidget(
            moviesList: state.listTrendingMovies,
          );
        }

        if (state is MoviesErrorState) {
          return errorMessage(state.message, context);
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  errorMessage(String message, BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            key: const Key("error-message"),
            title: Text(message),
            actions: [
              ElevatedButton(
                child: const Text("Tentar novamente"),
                onPressed: () {
                  getIt<MovieBloc>().add(
                    const PopularMoviesLoadEvent(),
                  );
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }
}
