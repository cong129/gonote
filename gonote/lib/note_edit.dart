import 'package:flutter/material.dart';
import 'package:gonote/model/note.dart';
import "package:http/http.dart" as http;
import "dart:convert";

class NoteEdit extends StatelessWidget {
  NoteEdit(
      {super.key,
      required this.note,
      required this.index,
      required this.onEdit});
  Note note;
  final int index;
  final void Function(int index, Note note) onEdit;

  @override
  Widget build(BuildContext context) {
    void submitEdit(int id, String title, String note) async {
      Note afterEditNote = Note(
        id: id,
        title: title,
        editTime: DateTime.now(),
        note: note,
      );

      final url = Uri.http(SERVER_URL, "/notes/$id");
      print(url);

      final response = await http.put(
        url,
        headers: {"Content-type": "application/json"},
        body: json.encode(afterEditNote.toJson()),
      );
      final updatedId = json.decode(response.body);
      print(updatedId);

      onEdit(index, afterEditNote);
      if (!context.mounted) return;
      Navigator.pop(context);
    }

    final noteController = TextEditingController();
    final titleController = TextEditingController();
    titleController.text = note.title;
    noteController.text = note.note;

    return Scaffold(
      appBar: AppBar(
        title: Text(note.title),
        actions: [
          IconButton(
              onPressed: () {
                submitEdit(note.id, titleController.text, noteController.text);
              },
              icon: const Icon(Icons.edit_note))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            children: [
              Text(note.formattedDate),
              TextField(
                controller: titleController,
                maxLength: 50,
                decoration: const InputDecoration(
                  label: Text("Title"),
                ),
              ),
              TextField(
                controller: noteController,
                keyboardType: TextInputType.multiline,
                minLines: 1,
                maxLines: null,
                decoration: const InputDecoration(
                  label: Text("Note"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
