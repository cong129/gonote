import 'package:flutter/material.dart';
import 'package:gonote/model/note.dart';
import 'package:gonote/note_edit.dart';
import 'package:gonote/widget/note_item.dart';

class NotesList extends StatelessWidget {
  const NotesList({
    super.key,
    required this.notes,
    required this.onRemoveNote,
    required this.onEditNote,
  });

  final List<Note> notes;
  final void Function(Note note) onRemoveNote;
  final void Function(int index, Note note) onEditNote;

  void _selectNote(BuildContext context, Note selectedNote, int index) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => NoteEdit(
          note: selectedNote,
          index: index,
          onEdit: onEditNote,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: notes.length,
      itemBuilder: (ctx, index) => Dismissible(
        background: Container(
          color: Colors.blueAccent,
          margin: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 40,
          ),
        ),
        key: ValueKey(notes[index]),
        onDismissed: (direction) {
          onRemoveNote(notes[index]);
        },
        child: NoteItem(
          index,
          notes[index],
          onSelectNote: () {
            _selectNote(context, notes[index], index);
          },
        ),
      ),
    );
  }
}
