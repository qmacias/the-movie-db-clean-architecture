import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:skeletons/skeletons.dart';
import 'package:the_movies_db_clean_architecture/domain/entities/movie_entity.dart';
import 'package:the_movies_db_clean_architecture/features/presentation/bloc/movie_bloc.dart';
import 'package:the_movies_db_clean_architecture/features/presentation/widgets/skeleton_movie_widget.dart';

import '../helpers/makeTestableWidget.dart';

class MockMovieBloc extends MockBloc<MovieEvent, MovieState>
    implements MovieBloc {}

void main() {
  late MovieBloc movieBloc;

  setUp(() {
    registerFallbackValue(
      const PopularMoviesLoadEvent(),
    );
    registerFallbackValue(const PopularMoviesLoadedState(
      listPopularMovies: <MovieEntity>[],
    ));

    movieBloc = MockMovieBloc();
  });

  group("Widget SkeletonMovieWidget |", () {
    testWidgets('should return the main widgets', (tester) async {
      when(() => movieBloc.state).thenReturn(const PopularMovieLoadingState());

      whenListen(
        movieBloc,
        Stream.fromIterable([
          const PopularMovieLoadingState(),
          const PopularMoviesLoadedState(listPopularMovies: <MovieEntity>[]),
        ]),
      );
      await tester.pumpWidget(
        makeTestableWidget(
          child: const SkeletonMovieWidget(),
          movieBloc: movieBloc,
        ),
      );

      expect(find.byType(Container), findsWidgets);
      expect(find.byType(ListView), findsWidgets);
      expect(find.byType(SkeletonAvatar), findsWidgets);
    });
  });
}
