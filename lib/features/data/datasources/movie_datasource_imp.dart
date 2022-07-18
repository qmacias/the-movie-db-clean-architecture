import 'dart:convert';

import 'package:the_movies_db_clean_architecture/core/errors/exceptions.dart';
import 'package:the_movies_db_clean_architecture/core/http_client/http_client.dart';
import 'package:the_movies_db_clean_architecture/core/utils/keys/themoviedb_key.dart';
import 'package:the_movies_db_clean_architecture/features/data/datasources/endpoints/themoviedb_endpoints.dart';
import 'package:the_movies_db_clean_architecture/features/data/datasources/movie_datasource.dart';
import 'package:the_movies_db_clean_architecture/features/data/models/movie_model.dart';

class TheMoviedbDatasourceImp implements MovieDatasource {
  final HttpClient client;

  TheMoviedbDatasourceImp(this.client);

  @override
  Future<List<MovieModel>> getListPopularMovies() async {
    final response = await client.get(
      TheMoviedbEndpoints.popularMovies(ThemovieDBKey.apiKey),
    );
    if (response.statusCode == 200) {
      var json = jsonDecode(response.data);
      List<MovieModel> listPopularMovies = [];
      listPopularMovies = json['results']
          .map<MovieModel>((movie) => MovieModel.fromJson(movie))
          .toList();
      return listPopularMovies;
    } else if (response.statusCode == 503) {
      throw const ServerException();
    } else {
      throw Exception();
    }
  }

  @override
  Future<List<MovieModel>> getListTrendingMovies() async {
    final response = await client.get(
      TheMoviedbEndpoints.trendingMovies(ThemovieDBKey.apiKey),
    );
    if (response.statusCode == 200) {
      var json = jsonDecode(response.data);
      List<MovieModel> listTrendingMovies = [];
      listTrendingMovies = json['results']
          .map<MovieModel>((movie) => MovieModel.fromJson(movie))
          .toList();
      return listTrendingMovies;
    } else if (response.statusCode == 503) {
      throw const ServerException();
    } else {
      throw Exception();
    }
  }
}
