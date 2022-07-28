import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:the_movies_db_clean_architecture/domain/entities/movie_entity.dart';
import 'package:the_movies_db_clean_architecture/features/presentation/bloc/movie_bloc.dart';
import 'package:the_movies_db_clean_architecture/features/presentation/widgets/item_movie_widget.dart';

import '../helpers/makeTestableWidget.dart';

class MockMovieBloc extends MockBloc<MovieEvent, MovieState>
    implements MovieBloc {}

void main() {
  late MovieBloc movieBloc;

  setUp(() {
    movieBloc = MockMovieBloc();
  });

  group("Widget ItemMovieWidget |", () {
    testWidgets('should return the main widgets', (tester) async {
      when(() => movieBloc.state).thenReturn(
        const PopularMoviesLoadedState(listPopularMovies: <MovieEntity>[]),
      );
      await mockNetworkImagesFor(() async => await tester.pumpWidget(
            makeTestableWidget(
              child: const ItemMovieWidget(
                title: "The Princess",
                voteAverage: 75,
                imageURL: "/9pCoqX24a6rE981fY1O3PmhiwrB.jpg",
                date: "2022-06-16",
              ),
              movieBloc: movieBloc,
            ),
          ));

      expect(find.byType(Column), findsWidgets);
      expect(find.byType(Stack), findsWidgets);
      expect(find.byType(Card), findsWidgets);
      expect(find.byType(ClipRRect), findsWidgets);
      expect(find.byType(Positioned), findsWidgets);
    });
  });
}
