import 'package:flutter/material.dart';
import 'package:gonote/model/note.dart';
import 'package:gonote/widget/new_note.dart';
import 'package:gonote/widget/notes_list.dart';

class Notes extends StatefulWidget {
  const Notes({super.key});

  @override
  State<Notes> createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  final List<Note> _registeredNotes = [];

  void _addNote(Note note) {
    setState(() {
      _registeredNotes.add(note);
    });
  }

  void _editItem(index, Note note) {
    setState(() {
      _registeredNotes[index] = note;
    });
  }

  void _openAddNoteOverlay() {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewNote(onAddnote: _addNote),
    );
  }

  void _removeNote(Note note) {
    final noteIndex = _registeredNotes.indexOf(note);
    setState(() {
      _registeredNotes.remove(note);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text("Note deleted."),
        action: SnackBarAction(
          label: "Undo",
          onPressed: () {
            setState(() {
              _registeredNotes.insert(noteIndex, note);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent = const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("No note found."),
          SizedBox(height: 20),
          Text("Start adding some!"),
        ],
      ),
    );

    if (_registeredNotes.isNotEmpty) {
      mainContent = NotesList(
        notes: _registeredNotes,
        onRemoveNote: _removeNote,
        onEditNote: _editItem,
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text("Gonote"),
        actions: [
          IconButton(
            onPressed: _openAddNoteOverlay,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: mainContent,
    );
  }
}
