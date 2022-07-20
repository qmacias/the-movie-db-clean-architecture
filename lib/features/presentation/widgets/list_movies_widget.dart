import 'package:flutter/material.dart';
import 'package:the_movies_db_clean_architecture/domain/entities/movie_entity.dart';
import 'package:the_movies_db_clean_architecture/features/presentation/pages/home_page_mixin.dart';
import 'package:the_movies_db_clean_architecture/features/presentation/widgets/item_movie_widget.dart';

class ListMovieWidget extends StatelessWidget with HomePageMixin {
  final List<MovieEntity> moviesList;
  const ListMovieWidget({Key? key, required this.moviesList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: moviesList.length,
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (_, index) {
          final movie = moviesList[index];
          return ItemMovieWidget(
            title: movie.title,
            imageURL: movie.posterPath,
            voteAverage: formatterVoteAverage(movie.voteAverage),
            date: movie.releaseDate,
          );
        });
  }
}
