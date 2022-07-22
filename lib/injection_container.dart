import 'package:get_it/get_it.dart';
import 'package:the_movies_db_clean_architecture/core/http_client/http_client.dart';
import 'package:the_movies_db_clean_architecture/core/http_client/http_client_imp.dart';
import 'package:the_movies_db_clean_architecture/data/datasources/movie_datasource.dart';
import 'package:the_movies_db_clean_architecture/data/datasources/themoviedb_datasource_imp.dart';
import 'package:the_movies_db_clean_architecture/data/repositories/movie_repository_imp.dart';
import 'package:the_movies_db_clean_architecture/domain/repositories/movie_repository.dart';
import 'package:the_movies_db_clean_architecture/domain/usecases/get_list_popular_movies_usecase.dart';
import 'package:the_movies_db_clean_architecture/domain/usecases/get_list_trending_movies_usecase.dart';
import 'package:the_movies_db_clean_architecture/features/presentation/bloc/movie_bloc.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  //register blocs
  getIt.registerFactory<MovieBloc>(() => MovieBloc(
        getListMoviesPopularUseCase: getIt(),
        getListMoviesTrendingUsecase: getIt(),
      ));

  //register usecases
  getIt.registerLazySingleton<GetListPopularMoviesUseCase>(
    () => GetListPopularMoviesUseCase(repository: getIt()),
  );
  getIt.registerLazySingleton<GetListTrendingMoviesUsecase>(
    () => GetListTrendingMoviesUsecase(repository: getIt()),
  );

  //register repositories
  getIt.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImp(movieDatasource: getIt()),
  );

  //register datasources
  getIt.registerLazySingleton<MovieDatasource>(
    () => TheMoviedbDatasourceImp(client: getIt()),
  );

  //register http client
  getIt.registerLazySingleton<HttpClient>(() => HttpClientImp());
}
