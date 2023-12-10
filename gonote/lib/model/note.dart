// import "package:flutter/material.dart";
import "package:intl/intl.dart";

final timeFormatter = DateFormat.Md().add_jm();

class Note {
  Note({
    required this.id,
    required this.title,
    required this.note,
    required this.editTime,
  });

  int id;
  String title;
  String note;
  DateTime editTime;

  String get formattedDate {
    return timeFormatter.format(editTime);
  }
}
