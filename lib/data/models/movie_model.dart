import 'package:the_movies_db_clean_architecture/core/utils/keys/themoviedb_key.dart';
import 'package:the_movies_db_clean_architecture/domain/entities/movie_entity.dart';

class MovieModel extends MovieEntity {
  const MovieModel(
      {required String title,
      required String releaseDate,
      required String posterPath,
      required double voteAverage})
      : super(
            title: title,
            releaseDate: releaseDate,
            posterPath: posterPath,
            voteAverage: voteAverage);

  factory MovieModel.fromJson(Map<String, dynamic> json) => MovieModel(
        title: json['title'] as String,
        releaseDate: json['release_date'] as String,
        posterPath: "${ThemovieDBKey.baseUrlImage}${json['poster_path']}",
        voteAverage: double.parse((json['vote_average']).toString()),
      );

  Map<String, dynamic> toJson() => {
        'title': title,
        'release_date': releaseDate,
        'poster_path': posterPath,
        'vote_average': voteAverage,
      };
}
