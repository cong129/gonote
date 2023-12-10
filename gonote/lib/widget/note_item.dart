import 'package:flutter/material.dart';
import 'package:gonote/model/note.dart';
import 'package:gonote/note_edit.dart';
import 'package:gonote/widget/new_note.dart';

class NoteItem extends StatelessWidget {
  const NoteItem(this.index, this.note,
      {super.key, required this.onSelectNote});
  final int index;
  final Note note;
  final void Function() onSelectNote;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onSelectNote,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 16,
          ),
          child: Column(children: [
            Text(
              note.title,
            ),
            const SizedBox(
              height: 4,
            ),
            Row(
              children: [
                Text(note.formattedDate),
                const Spacer(),
                Text(note.note),
              ],
            )
          ]),
        ),
      ),
    );
  }
}
