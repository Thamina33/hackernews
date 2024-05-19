import 'package:intl/intl.dart';

String convertUnixToHumanReadable(int timestamp) {
  // Convert Unix timestamp to DateTime
  DateTime date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
  // Format DateTime using intl package
  String formattedDate = DateFormat('dd MMMM yyyy hh:mm a').format(date);
  return formattedDate;
}