import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String formatDate(int millisecondsFromEpoch) {
  return DateFormat.yMMMMd()
      .format(DateTime.fromMillisecondsSinceEpoch(millisecondsFromEpoch));
}

String formatTime(BuildContext context, int hour, minute) {
  return TimeOfDay(hour: hour, minute: minute).format(context);
}

void showSnackBar(BuildContext context, String message) {
  final snackBar = SnackBar(
    content: Text(
      message,
      style: TextStyle(color: Theme.of(context).hintColor),
    ),
    duration: const Duration(
      seconds: 2,
    ),
    backgroundColor: Theme.of(context).cardColor,
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

String formatNumberAsMoney(num total) {
  return NumberFormat('#,##0.00').format(total);
}
