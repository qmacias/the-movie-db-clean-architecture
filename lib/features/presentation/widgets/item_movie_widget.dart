import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:the_movies_db_clean_architecture/core/utils/constants/custom_colors.dart';
import 'package:the_movies_db_clean_architecture/core/utils/constants/custom_styles.dart';
import 'package:the_movies_db_clean_architecture/core/utils/enums/enums.dart';
import 'package:the_movies_db_clean_architecture/core/utils/helpers/date_formatter.dart';
import 'package:the_movies_db_clean_architecture/features/presentation/pages/home_page_mixin.dart';

class ItemMovieWidget extends StatefulWidget {
  final String title;
  final String imageURL;
  final String date;
  final int voteAverage;
  const ItemMovieWidget({
    Key? key,
    required this.title,
    required this.imageURL,
    required this.voteAverage,
    required this.date,
  }) : super(key: key);

  @override
  State<ItemMovieWidget> createState() => _ItemMovieWidgetState();
}

class _ItemMovieWidgetState extends State<ItemMovieWidget> with HomePageMixin {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 250,
          width: 150,
          child: Stack(
            children: [
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(7),
                  child: Image.network(
                    widget.imageURL,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      }
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                    fit: BoxFit.cover,
                    width: 150,
                    height: 225,
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 15,
                child: _percenteAverage(),
              ),
              Positioned(
                right: 10,
                top: 10,
                child: Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.white.withOpacity(0.8),
                  ),
                  child: _popMenuOptions(),
                ),
              ),
            ],
          ),
        ),
        Tooltip(
          message: widget.title,
          child: Text(
            formatterTitle(widget.title),
            style: CustomStyles.styleTextTitle,
          ),
        ),
        Text(
          DateFormatter.formatDate(widget.date),
          style: CustomStyles.styleTextSubtitle,
        ),
      ],
    );
  }

  Widget _percenteAverage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(100),
      child: CircularPercentIndicator(
        radius: 25,
        percent: widget.voteAverage / 100,
        circularStrokeCap: CircularStrokeCap.round,
        lineWidth: 4,
        animation: true,
        animationDuration: 3000,
        progressColor: selectColorPercentIndicator(widget.voteAverage),
        backgroundColor: CustomColors.tmdbGrey,
        fillColor: CustomColors.tmdbDarkBlue,
        center: RichText(
          text: TextSpan(children: [
            TextSpan(
              text: widget.voteAverage.toString(),
              style: CustomStyles.stylePercentText,
            ),
            WidgetSpan(
              child: Transform.translate(
                offset: const Offset(2, -7),
                child: const Text(
                  '%',
                  textScaleFactor: 0.5,
                  style: CustomStyles.stylePercentText,
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }

  Widget _popMenuOptions() {
    return PopupMenuButton(
      tooltip: "Suas opcões",
      child: Container(
        height: 30,
        width: 30,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Colors.white.withOpacity(0.8),
        ),
        child: const Icon(
          Icons.keyboard_control_sharp,
          size: 30,
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(7),
      ),
      itemBuilder: (context) {
        return [
          const PopupMenuItem(
            child: ListTile(
              leading: Icon(Icons.view_list_rounded, color: Colors.black),
              title: Text(
                'Adicionar a uma lista',
                style: CustomStyles.stylePopupMenu,
              ),
            ),
            value: PopMenuValueEnum.addToAList,
          ),
          const PopupMenuItem(
            child: ListTile(
              leading: Icon(
                Icons.favorite_rounded,
                color: Colors.black,
              ),
              title: Text(
                'Adicionar aos favoritos',
                style: CustomStyles.stylePopupMenu,
              ),
            ),
            value: PopMenuValueEnum.addToFavorites,
          ),
          const PopupMenuItem(
            child: ListTile(
              leading: Icon(Icons.bookmark, color: Colors.black),
              title: Text(
                "Lista de interesses",
                style: CustomStyles.stylePopupMenu,
              ),
            ),
            value: PopMenuValueEnum.addListIntersted,
          ),
          const PopupMenuItem(
            child: ListTile(
              leading: Icon(Icons.star_rate_rounded, color: Colors.black),
              title: Text(
                "Sua avaliação",
                style: CustomStyles.stylePopupMenu,
              ),
            ),
            value: PopMenuValueEnum.addYourAvaliation,
          ),
        ];
      },
    );
  }
}
