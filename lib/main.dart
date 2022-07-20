import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:the_movies_db_clean_architecture/core/utils/constants/custom_colors.dart';
import 'package:the_movies_db_clean_architecture/domain/usecases/get_list_movies_popular_usecase.dart';
import 'package:the_movies_db_clean_architecture/domain/usecases/get_list_movies_trending_usecase.dart';
import 'package:the_movies_db_clean_architecture/features/presentation/bloc/movie_bloc.dart';
import 'package:the_movies_db_clean_architecture/features/presentation/pages/home_page.dart';
import 'package:the_movies_db_clean_architecture/injection_container.dart';

void main() async {
  await init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider<MovieBloc>(
      create: (context) => MovieBloc(
        getListMoviesPopularUseCase: getIt<GetListMoviesPopularUseCase>(),
        getListMoviesTrendingUsecase: getIt<GetListMoviesTrendingUsecase>(),
      ),
      child: MaterialApp(
        title: 'The Movies DB',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: "SourceSansPro",
          primaryColor: CustomColors.tmdbDarkBlue,
          colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: CustomColors.tmdbDarkBlue,
            secondary: CustomColors.tmdbLighterGreen,
          ),
        ),
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale("pt", "BR"),
        ],
        home: const HomePage(),
      ),
    );
  }
}
