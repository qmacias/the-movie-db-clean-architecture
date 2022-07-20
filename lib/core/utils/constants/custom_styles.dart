import 'package:flutter/material.dart';
import 'package:the_movies_db_clean_architecture/core/utils/constants/custom_colors.dart';

class CustomStyles {
  static const styleTextTitle = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 16,
  );
  static const stylePopupMenu = TextStyle(
    fontSize: 14,
  );

  static const styleTextSubtitle = TextStyle(
    color: CustomColors.tmdbGrey,
  );

  static const styleTextBody = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
  );

  static const styleTextTopic = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
  );

  static const stylePercentText = TextStyle(
    color: Colors.white,
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );

  static const styleTextError = TextStyle(
    color: Colors.red,
    fontSize: 16,
  );
}
