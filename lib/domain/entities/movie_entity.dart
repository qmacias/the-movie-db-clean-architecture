import 'package:equatable/equatable.dart';

class MovieEntity extends Equatable {
  final String title;
  final String releaseDate;
  final String posterPath;
  final double voteAverage;

  const MovieEntity({
    required this.title,
    required this.releaseDate,
    required this.posterPath,
    required this.voteAverage,
  });

  @override
  List<Object?> get props => [];
}
