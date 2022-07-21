import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:the_movies_db_clean_architecture/data/models/movie_model.dart';
import 'package:the_movies_db_clean_architecture/domain/entities/movie_entity.dart';

import '../../../mocks/movie_mock.dart';

void main() {
  const movieModel = MovieModel(
    title: 'Jurassic World Dominion',
    posterPath: '/kAVRgw7GgK1CfYEJq8ME6EvRIgU.jpg',
    releaseDate: '2022-06-01',
    voteAverage: 6.682,
  );

  setUp(() {});

  group('MovieModel |', () {
    test('should be a subclass of MovieEntity', () {
      expect(movieModel, isA<MovieEntity>());
    });

    test('should return a valid model', () {
      final Map<String, dynamic> jsonMap = json.decode(movieMock);
      final result = MovieModel.fromJson(jsonMap);
      expect(movieModel, result);
    });

    test("should return a json map containing the proper data.", () {
      final result = movieModel.toJson();
      final expectedMap = {
        'title': 'Jurassic World Dominion',
        'release_date': '2022-06-01',
        'poster_path': '/kAVRgw7GgK1CfYEJq8ME6EvRIgU.jpg',
        'vote_average': 6.682,
      };
      expect(result, expectedMap);
    });
  });
}
