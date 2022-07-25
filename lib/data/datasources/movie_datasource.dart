import 'package:the_movies_db_clean_architecture/data/models/movie_model.dart';

abstract class MovieDatasource {
  Future<List<MovieModel>> getPopularMovies();
  Future<List<MovieModel>> getTrendingMovies();
}
