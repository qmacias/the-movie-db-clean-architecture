import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:the_movies_db_clean_architecture/features/presentation/bloc/movie_bloc.dart';
import 'package:the_movies_db_clean_architecture/features/presentation/widgets/body_home_widget.dart';
import 'package:the_movies_db_clean_architecture/features/presentation/widgets/list_movies_popular_or_trending_widget.dart';

import '../helpers/makeTestableWidget.dart';

class MockMovieBloc extends MockBloc<MovieEvent, MovieState>
    implements MovieBloc {}

void main() {
  late MovieBloc movieBloc;

  setUp(() {
    movieBloc = MockMovieBloc();
  });

  group("Widget BodyHomeWidget |", () {
    testWidgets('should return the main widgets', (tester) async {
      when(() => movieBloc.state).thenReturn(const PopularMovieLoadingState());

      await tester.pumpWidget(
        makeTestableWidget(
          child: const BodyHomeWidget(),
          movieBloc: movieBloc,
        ),
      );

      expect(find.byType(Column), findsOneWidget);
      expect(find.byType(Text), findsWidgets);
      expect(find.byType(SizedBox), findsWidgets);
      expect(find.byType(ListMoviePopularOrTrendingWidget), findsWidgets);
    });
  });
}
