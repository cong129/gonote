// import "package:flutter/material.dart";
import "package:intl/intl.dart";

final timeFormatter = DateFormat.Md().add_jm();

const String SERVER_URL = "10.0.2.2:3000";

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

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'edit_time': editTime.toIso8601String(), // DateTime을 문자열로 변환
      'note_detail': note,
    };
  }
}
