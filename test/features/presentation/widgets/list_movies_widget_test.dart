import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:the_movies_db_clean_architecture/domain/entities/movie_entity.dart';
import 'package:the_movies_db_clean_architecture/features/presentation/bloc/movie_bloc.dart';
import 'package:the_movies_db_clean_architecture/features/presentation/widgets/list_movies_widget.dart';

import '../helpers/makeTestableWidget.dart';
import 'list_movies_popular_or_trending_widget_test.dart';

void main() {
  late MovieBloc movieBloc;

  setUpAll(() {
    registerFallbackValue(const PopularMoviesLoadEvent());
    registerFallbackValue(const PopularMoviesLoadedState(
      listPopularMovies: <MovieEntity>[],
    ));
    movieBloc = MockMovieBloc();
  });

  group("ListMovieWidget |", () {
    testWidgets('should show all the main widgets.',
        (WidgetTester tester) async {
      when(() => movieBloc.state).thenReturn(
        const PopularMoviesLoadedState(
          listPopularMovies: <MovieEntity>[],
        ),
      );

      await tester.pumpWidget(
        makeTestableWidget(
          movieBloc: movieBloc,
          child: const ListMovieWidget(
            moviesList: <MovieEntity>[],
          ),
        ),
      );

      expect(find.byType(ListView), findsOneWidget);
    });
  });
}
