// ignore_for_file: constant_identifier_names

class TheMoviedbEndpoints {
  static const String BASE_API_URL = "https://api.themoviedb.org/3";

  static String popularMovies(String apiKey, int page) =>
      '$BASE_API_URL/movie/popular?api_key=$apiKey&page=$page';

  static String trendingMovies(String apiKey) =>
      '$BASE_API_URL/trending/movie/week?api_key=$apiKey';
}
