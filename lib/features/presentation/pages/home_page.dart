import 'package:flutter/material.dart';
import 'package:the_movies_db_clean_architecture/features/presentation/pages/home_page_mixin.dart';
import 'package:the_movies_db_clean_architecture/features/presentation/widgets/body_home_widget.dart';

class HomePage extends StatelessWidget with HomePageMixin {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Image.asset(
            'lib/core/assets/images/tmdb_logo.JPEG',
            height: 80,
          ),
          centerTitle: true,
        ),
        body: const Padding(
          padding: EdgeInsets.only(left: 15),
          child: BodyHomeWidget(),
        ));
  }
}
