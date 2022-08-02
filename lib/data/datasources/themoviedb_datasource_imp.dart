import 'dart:convert';

import 'package:the_movies_db_clean_architecture/core/errors/exceptions.dart';
import 'package:the_movies_db_clean_architecture/core/http_client/http_client.dart';
import 'package:the_movies_db_clean_architecture/core/utils/keys/themoviedb_key.dart';
import 'package:the_movies_db_clean_architecture/data/datasources/movie_datasource.dart';
import 'package:the_movies_db_clean_architecture/data/datasources/themoviesdb_endpoints/themoviedb_endpoints.dart';
import 'package:the_movies_db_clean_architecture/data/models/movie_model.dart';

class TheMoviedbDatasourceImp implements MovieDatasource {
  final HttpClient client;

  TheMoviedbDatasourceImp({required this.client});

  @override
  Future<List<MovieModel>> getPopularMovies() async {
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
    } else if (response.statusCode == 404) {
      throw const NotFoundException();
    } else {
      throw const ExecptionGenerics();
    }
  }

  @override
  Future<List<MovieModel>> getTrendingMovies() async {
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
    } else if (response.statusCode == 404) {
      throw const NotFoundException();
    } else {
      throw const ExecptionGenerics();
    }
  }
}
