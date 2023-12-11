import 'package:flutter/material.dart';
import 'package:gonote/model/note.dart';

const int MAX_NOTE_LENGTH = 20;

class NoteItem extends StatelessWidget {
  const NoteItem(this.index, this.note,
      {super.key, required this.onSelectNote});
  final int index;
  final Note note;
  final void Function() onSelectNote;

  @override
  Widget build(BuildContext context) {
    int noteLength;
    if (note.note.length < MAX_NOTE_LENGTH) {
      noteLength = note.note.length;
    } else {
      noteLength = MAX_NOTE_LENGTH;
    }
    return InkWell(
      onTap: onSelectNote,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 16,
          ),
          child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  note.title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(note.formattedDate),
              ],
            ),
            const Spacer(),
            Text(note.note.substring(0, noteLength)),
          ]),
        ),
      ),
    );
  }
}
