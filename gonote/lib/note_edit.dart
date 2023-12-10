import 'package:flutter/material.dart';
import 'package:gonote/model/note.dart';

class NoteEdit extends StatelessWidget {
  NoteEdit(
      {super.key,
      required this.note,
      required this.index,
      required this.onEdit});
  Note note;
  int index;
  final void Function(int index, Note note) onEdit;

  @override
  Widget build(BuildContext context) {
    void submitEdit(int id, String title, String note) {
      Note afterEditNote = Note(
        id: id,
        title: title,
        editTime: DateTime.now(),
        note: note,
      );
      onEdit(index, afterEditNote);
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
