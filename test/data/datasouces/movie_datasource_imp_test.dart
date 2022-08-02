import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:the_movies_db_clean_architecture/core/errors/exceptions.dart';
import 'package:the_movies_db_clean_architecture/core/http_client/http_client.dart';
import 'package:the_movies_db_clean_architecture/data/datasources/themoviedb_datasource_imp.dart';
import 'package:the_movies_db_clean_architecture/data/models/movie_model.dart';

class MockHttpClient extends Mock implements HttpClient {}

void main() {
  late TheMoviedbDatasourceImp movieDatasourceImp;
  late HttpClient client;

  const listPopularMock =
      """{"page":1,"results":[{"title":"Jurassic World Dominion","poster_path":"/kAVRgw7GgK1CfYEJq8ME6EvRIgU.jpg","release_date":"2022-06-01","vote_average":6.682}]}""";

  setUp(() {
    client = MockHttpClient();
    movieDatasourceImp = TheMoviedbDatasourceImp(client: client);
  });

  group("Datasource PopularMovies |", () {
    test("should a list popular movies when is sucessful", () async {
      when(() => client.get(any())).thenAnswer(
          (_) async => HttpResponse(data: listPopularMock, statusCode: 200));
      final result = await movieDatasourceImp.getPopularMovies();
      expect(result, isA<List<MovieModel>>());
    });

    test("should throw a NotFoundException when the call is not successful",
        () async {
      when(() => client.get(any())).thenAnswer((_) async =>
          HttpResponse(statusCode: 404, data: "Ops! something went wrong"));
      final result = movieDatasourceImp.getPopularMovies();
      expect(result, throwsA(const NotFoundException()));
    });

    test("should throw a ServerException when the call is not successful",
        () async {
      when(() => client.get(any())).thenAnswer((_) async =>
          HttpResponse(statusCode: 503, data: "Ops! something went wrong"));
      final result = movieDatasourceImp.getPopularMovies();
      expect(result, throwsA(const ServerException()));
    });

    test("should throw a Exception Generics when the call is not successful",
        () {
      when(() => client.get(any())).thenAnswer((_) async =>
          HttpResponse(statusCode: 500, data: "Ops! something went wrong"));
      final result = movieDatasourceImp.getPopularMovies();
      expect(result, throwsA(const ExecptionGenerics()));
    });
  });

  group("Datasource TrendingMovies |", () {
    test("should a list trending movies when is sucessful", () async {
      when(() => client.get(any())).thenAnswer(
          (_) async => HttpResponse(data: listPopularMock, statusCode: 200));
      final result = await movieDatasourceImp.getTrendingMovies();
      expect(result, isA<List<MovieModel>>());
    });

    test("should throw a NotFoundException when the call is not successful",
        () async {
      when(() => client.get(any())).thenAnswer((_) async =>
          HttpResponse(statusCode: 404, data: "Ops! something went wrong"));
      final result = movieDatasourceImp.getTrendingMovies();
      expect(result, throwsA(const NotFoundException()));
    });

    test("should throw a ServerException when the call is not successful",
        () async {
      when(() => client.get(any())).thenAnswer((_) async =>
          HttpResponse(statusCode: 503, data: "Ops! something went wrong"));
      final result = movieDatasourceImp.getTrendingMovies();
      expect(result, throwsA(const ServerException()));
    });

    test("should throw a Exception Generics when the call is not successful",
        () {
      when(() => client.get(any())).thenAnswer((_) async =>
          HttpResponse(statusCode: 500, data: "Ops! something went wrong"));
      final result = movieDatasourceImp.getTrendingMovies();
      expect(result, throwsA(const ExecptionGenerics()));
    });
  });
}
