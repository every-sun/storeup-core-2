import 'package:intl/intl.dart';

String formatToDate(dateTime) {
  final DateFormat formatter = DateFormat('yyyy.MM.dd');
  return formatter.format(dateTime);
}

String formatToDateAndHour(dateTime) {
  final DateFormat formatter = DateFormat('yyyy.MM.dd HH:mm');
  return formatter.format(dateTime);
}
