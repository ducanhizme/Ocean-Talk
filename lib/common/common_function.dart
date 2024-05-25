import 'package:intl/intl.dart';

String formatDate(DateTime dateTime) {
  var formatter = DateFormat('dd/MM/yyyy');
  String formatted = formatter.format(dateTime);
  return formatted;
}