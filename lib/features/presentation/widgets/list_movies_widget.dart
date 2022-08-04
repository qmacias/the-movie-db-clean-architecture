import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movies_db_clean_architecture/domain/entities/movie_entity.dart';
import 'package:the_movies_db_clean_architecture/features/presentation/bloc/movie_bloc.dart';
import 'package:the_movies_db_clean_architecture/features/presentation/pages/home_page_mixin.dart';
import 'package:the_movies_db_clean_architecture/features/presentation/widgets/item_movie_widget.dart';

class ListMovieWidget extends StatefulWidget {
  final List<MovieEntity> moviesList;
  const ListMovieWidget({Key? key, required this.moviesList}) : super(key: key);

  @override
  State<ListMovieWidget> createState() => _ListMovieWidgetState();
}

class _ListMovieWidgetState extends State<ListMovieWidget> with HomePageMixin {
  late ScrollController _scrollController;
  bool _isLoading = false;

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _onScrollEnd();
      }
    });
    super.initState();
  }

  _onScrollEnd() {
    if (!_isLoading) {
      setState(() {
        _isLoading = true;
      });
      BlocProvider.of<MovieBloc>(context).add(
        const PopularMoviesLoadEvent(),
      );
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        controller: _scrollController,
        itemCount: widget.moviesList.length,
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (_, index) {
          final movie = widget.moviesList[index];
          return ItemMovieWidget(
            title: movie.title,
            imageURL: movie.posterPath,
            voteAverage: formatterVoteAverage(movie.voteAverage),
            date: movie.releaseDate,
          );
        });
  }
}
