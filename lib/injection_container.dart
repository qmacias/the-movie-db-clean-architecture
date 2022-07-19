import 'package:get_it/get_it.dart';
import 'package:the_movies_db_clean_architecture/core/http_client/http_client.dart';
import 'package:the_movies_db_clean_architecture/core/http_client/http_client_imp.dart';
import 'package:the_movies_db_clean_architecture/data/datasources/movie_datasource.dart';
import 'package:the_movies_db_clean_architecture/data/datasources/movie_datasource_imp.dart';
import 'package:the_movies_db_clean_architecture/data/repositories/movie_repository_imp.dart';
import 'package:the_movies_db_clean_architecture/domain/repositories/movie_repository.dart';
import 'package:the_movies_db_clean_architecture/domain/usecases/get_list_movies_popular_usecase.dart';
import 'package:the_movies_db_clean_architecture/domain/usecases/get_list_movies_trending_usecase.dart';
import 'package:the_movies_db_clean_architecture/features/presentation/bloc/movie_bloc.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  //register blocs
  getIt.registerFactory<MovieBloc>(() => MovieBloc(
        getListMoviesPopularUseCase: getIt<GetListMoviesPopularUseCase>(),
        getListMoviesTrendingUsecase: getIt<GetListMoviesTrendingUsecase>(),
      ));

  //register usecases
  getIt.registerLazySingleton(
    () => GetListMoviesPopularUseCase(repository: getIt<MovieRepository>()),
  );
  getIt.registerLazySingleton(
    () => GetListMoviesTrendingUsecase(repository: getIt<MovieRepository>()),
  );

  //register repositories
  getIt.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImp(movieDatasource: getIt<MovieDatasource>()),
  );

  //register datasources
  getIt.registerLazySingleton<MovieDatasource>(
    () => TheMoviedbDatasourceImp(client: getIt<HttpClient>()),
  );

  //register http client
  getIt.registerLazySingleton<HttpClient>(() => HttpClientImp());
}
