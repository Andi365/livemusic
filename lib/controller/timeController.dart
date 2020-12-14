import 'package:cloud_firestore/cloud_firestore.dart';

String formatTime(Timestamp time) {
  DateTime date = time.toDate();
  return '${date.day}-${date.month}-${date.year} ${date.hour}:${date.minute}';
}
