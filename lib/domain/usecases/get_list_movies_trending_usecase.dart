import 'package:dartz/dartz.dart';
import 'package:the_movies_db_clean_architecture/core/errors/failures.dart';
import 'package:the_movies_db_clean_architecture/core/usecase/usecase.dart';
import 'package:the_movies_db_clean_architecture/domain/entities/movie_entity.dart';
import 'package:the_movies_db_clean_architecture/domain/repositories/movie_repository.dart';

class GetListMoviesTrendingUsecase
    implements UseCase<List<MovieEntity>, NoParams> {
  GetListMoviesTrendingUsecase(this._repository);

  final MovieRepository _repository;

  @override
  Future<Either<Failure, List<MovieEntity>>> call(NoParams noParams) async {
    return await _repository.getListTrendingMovies();
  }
}
