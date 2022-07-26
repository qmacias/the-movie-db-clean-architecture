import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:the_movies_db_clean_architecture/features/presentation/bloc/movie_bloc.dart';

Widget makeTestableWidget({
  required Widget child,
  required MovieBloc movieBloc,
}) {
  return MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => movieBloc,
      ),
    ],
    child: MaterialApp(
      home: Scaffold(
        body: child,
      ),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale("pt", "BR"),
      ],
    ),
  );
}
