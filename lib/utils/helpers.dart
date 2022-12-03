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
      style: const TextStyle(
        color: Colors.yellow,
        fontSize: 15,
      ),
    ),
    duration: const Duration(
      seconds: 3,
    ),
    backgroundColor: Theme.of(context).cardColor,
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

Future<bool> removeAlertDialog(BuildContext context) async {
  // set up the buttons
  Widget cancelButton = TextButton(
    child: const Text("Cancel"),
    onPressed: () {
      Navigator.of(context).pop(false);
    },
  );

  Widget continueButton = TextButton(
    child: const Text("Continue"),
    onPressed: () {
      Navigator.of(context).pop(true);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: const Text("Delete"),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: const [
        Text("Delete item ?"),
        SizedBox(
          height: 3,
        ),
        Text("You wont be able to recover it"),
      ],
    ),
    actions: [
      cancelButton,
      continueButton,
    ],
  );

  // show the dialog
  return await showDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

String formatNumberAsMoney(num total) {
  return NumberFormat('#,##0.00').format(total);
}
