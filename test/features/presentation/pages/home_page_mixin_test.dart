import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:the_movies_db_clean_architecture/features/presentation/pages/home_page_mixin.dart';

void main() {
  late HomePageMixin homePageMixin;
  setUp(() {
    homePageMixin = HomePageMixin();
  });

  int random({min, max}) {
    return min + Random().nextInt(max - min);
  }

  group("HomePageMixin |", () {
    test('formatterTitle |', () {
      const String title = "The Shawshank Redemption";
      const String expected = "The Shawshank R...";
      final String actual = homePageMixin.formatterTitle(title);
      expect(actual, expected);
    });

    test('formatterVoteAverage |', () {
      const double voteAverage = 8.7;
      const int expected = 87;
      final int actual = homePageMixin.formatterVoteAverage(voteAverage);
      expect(actual, expected);
    });

    test('selectColorPercentIndicator | Green', () {
      int voteAverage = random(min: 70, max: 100);
      const Color expected = Colors.green;
      final Color actual =
          homePageMixin.selectColorPercentIndicator(voteAverage);
      expect(actual, expected);
    });

    test('selectColorPercentIndicator | Yellow', () {
      int voteAverage = random(min: 51, max: 69);
      const Color expected = Colors.yellow;
      final Color actual =
          homePageMixin.selectColorPercentIndicator(voteAverage);
      expect(actual, equals(expected));
    });

    test('selectColorPercentIndicator | Orange', () {
      int voteAverage = random(min: 21, max: 50);
      const Color expected = Colors.orange;
      final Color actual =
          homePageMixin.selectColorPercentIndicator(voteAverage);
      expect(actual, equals(expected));
    });

    test('selectColorPercentIndicator | Red', () {
      int voteAverage = random(min: 1, max: 20);
      const Color expected = Colors.red;
      final Color actual =
          homePageMixin.selectColorPercentIndicator(voteAverage);
      expect(actual, equals(expected));
    });
  });
}
