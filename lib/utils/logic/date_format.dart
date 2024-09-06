import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String dateFormatter({required String date}) {
  DateTime originalDate = DateTime.parse(date);
  String formattedDateStr = DateFormat('dd MMM yyyy').format(originalDate);
  return formattedDateStr;
}

String formatTimeOfDay(TimeOfDay time) {
  final hours = time.hour.toString().padLeft(2, '0');
  final minutes = time.minute.toString().padLeft(2, '0');
  return "$hours:$minutes";
}

String dateFormatterMillisecond({required String date}) {
  // DateTime originalDate = DateTime.parse(date);
  DateTime originalDate = DateTime.fromMillisecondsSinceEpoch(int.parse(date));
  String formattedDateStr = DateFormat('dd MMM yyyy').format(originalDate);
  return formattedDateStr;
}

String dateTimeFormatterMain({required String date}) {
  DateTime parsedDate = DateTime.parse(date);
  // DateTime parsedDate = DateTime.fromMillisecondsSinceEpoch(int.parse(date));
  String formattedDate = DateFormat("dd MMM yyyy, hh:mma").format(parsedDate);
  return formattedDate;
}

String dateTimeFormatter({required String date}) {
  // DateTime parsedDate = DateTime.parse(date);
  DateTime parsedDate =
      DateTime.fromMillisecondsSinceEpoch(int.parse("${date}000"));
  String formattedDate = DateFormat("dd MMM yyyy, hh:mma").format(parsedDate);
  return formattedDate;
}


String formatTimestampToDate(String timestamp) {
  // Convert the timestamp string to an integer
  int timestampInt = int.parse(timestamp);

  // Multiply by 1000 if the timestamp is in seconds (Unix time) to get milliseconds
  DateTime date = DateTime.fromMillisecondsSinceEpoch(timestampInt * 1000);

  // Use DateFormat from intl package to format the date as needed
  // Import 'package:intl/intl.dart';
  return DateFormat('dd MMM yyyy').format(date);
}

