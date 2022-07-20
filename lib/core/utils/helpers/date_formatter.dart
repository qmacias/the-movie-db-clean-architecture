import 'package:intl/intl.dart';

class DateFormatter {
  static String formatDate(String date) {
    final DateTime dateTime = DateTime.parse(date);
    return DateFormat.yMMMd('pt_Br').format(dateTime);
  }
}
