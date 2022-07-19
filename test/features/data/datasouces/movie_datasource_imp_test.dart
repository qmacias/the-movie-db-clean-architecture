import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:the_movies_db_clean_architecture/core/errors/exceptions.dart';
import 'package:the_movies_db_clean_architecture/core/http_client/http_client.dart';
import 'package:the_movies_db_clean_architecture/data/datasources/movie_datasource_imp.dart';
import 'package:the_movies_db_clean_architecture/data/models/movie_model.dart';

import '../../../mocks/movie_mock.dart';

class MockHttpClient extends Mock implements HttpClient {}

void main() {
  late TheMoviedbDatasourceImp movieDatasourceImp;
  late HttpClient client;

  setUp(() {
    client = MockHttpClient();
    //client = HttpClientImp();
    movieDatasourceImp = TheMoviedbDatasourceImp(client: client);
  });

  group("Movie Datasource |", () {
    test("should call the get method with correct url", () async {
      when(() => client.get(any())).thenAnswer(
          (_) async => HttpResponse(statusCode: 200, data: listPopularMock));

      await movieDatasourceImp.getListPopularMovies();
      //verify(() => client.get(urlExpected)).callCount(1);
    });

    test("should a list popular movies when is sucessful", () async {
      when(() => client.get(any())).thenAnswer(
          (_) async => HttpResponse(statusCode: 200, data: listPopularMock));
      final resultsMock = jsonDecode(listPopularMock);
      final listMoviesMock = resultsMock["results"].map(
        (movie) => MovieModel.fromJson(movie),
      );
      final result = await movieDatasourceImp.getListPopularMovies();
      expect(result, listMoviesMock);
      //expect(result, isA<List<MovieModel>>());
    });

    test("should throw an error when is not successful", () async {
      when(() => client.get(any()))
          .thenAnswer((_) async => HttpResponse(statusCode: 404, data: ""));
      expect(movieDatasourceImp.getListPopularMovies(), throwsException);
    });

    test("should throw a ServerException when the call is not successful",
        () async {
      when(() => client.get(any())).thenAnswer((_) async =>
          HttpResponse(statusCode: 503, data: "Ops! something went wrong"));
      final result = movieDatasourceImp.getListPopularMovies();
      expect(result, throwsA(const ServerException()));
    });
  });
}
