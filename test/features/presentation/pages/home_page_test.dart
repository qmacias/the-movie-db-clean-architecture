import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:the_movies_db_clean_architecture/domain/entities/movie_entity.dart';
import 'package:the_movies_db_clean_architecture/features/presentation/bloc/movie_bloc.dart';
import 'package:the_movies_db_clean_architecture/features/presentation/pages/home_page.dart';
import 'package:the_movies_db_clean_architecture/features/presentation/widgets/body_home_widget.dart';

import '../helpers/makeTestableWidget.dart';

class MockMovieBloc extends MockBloc<MovieEvent, MovieState>
    implements MovieBloc {}

void main() {
  late MovieBloc movieBloc;

  setUpAll(() {
    registerFallbackValue(const PopularMoviesLoadEvent());
    registerFallbackValue(const PopularMoviesLoadedState(
      listPopularMovies: <MovieEntity>[],
    ));
    movieBloc = MockMovieBloc();
  });

  group("HomePage |", () {
    testWidgets('should show all the main widgets on home screen.',
        (WidgetTester tester) async {
      when(() => movieBloc.state).thenReturn(
        const PopularMoviesLoadedState(
          listPopularMovies: <MovieEntity>[],
        ),
      );

      await tester.pumpWidget(
        makeTestableWidget(
          movieBloc: movieBloc,
          child: const HomePage(),
        ),
      );

      await tester.pump();
      expect(find.byType(AppBar), findsOneWidget);
      expect(find.byType(BodyHomeWidget), findsOneWidget);
    });
  });
}
