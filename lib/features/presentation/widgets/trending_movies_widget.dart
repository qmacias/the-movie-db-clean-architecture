import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movies_db_clean_architecture/core/utils/constants/custom_styles.dart';
import 'package:the_movies_db_clean_architecture/domain/entities/movie_entity.dart';
import 'package:the_movies_db_clean_architecture/features/presentation/bloc/movie_bloc.dart';
import 'package:the_movies_db_clean_architecture/features/presentation/pages/home_page_mixin.dart';
import 'package:the_movies_db_clean_architecture/features/presentation/widgets/list_movies_widget.dart';

class TrendingMoviesWidget extends StatelessWidget with HomePageMixin {
  final List<MovieEntity> listTrendingMovies;

  const TrendingMoviesWidget({
    Key? key,
    required this.listTrendingMovies,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieBloc, MovieState>(
      buildWhen: (previous, current) {
        return current is TrendingMoviesLoadedState;
      },
      builder: (context, state) {
        if (state is TrendingMovieLoadingState) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is TrendingMoviesLoadedState) {
          return ListMovieWidget(
            moviesList: state.listTrendingMovies,
          );
        }
        if (state is MoviesErrorState) {
          return const Text(
            'Erro ao carregar os filmes',
            style: CustomStyles.styleTextError,
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
