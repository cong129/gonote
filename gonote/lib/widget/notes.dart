import 'package:flutter/material.dart';
import 'package:gonote/model/note.dart';
import 'package:gonote/widget/new_note.dart';
import 'package:gonote/widget/notes_list.dart';
import "package:http/http.dart" as http;
import "dart:convert";

class Notes extends StatefulWidget {
  const Notes({super.key});

  @override
  State<Notes> createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  List<Note> _registeredNotes = [];

  void _loadItems() async {
    final url = Uri.http(SERVER_URL, "/all-note-titles");
    final response = await http.get(url);
    final listData = json.decode(response.body);
    // print(listData);
    final List<Note> loadedItems = [];
    for (final item in listData) {
      loadedItems.add(
        Note(
          id: item["id"],
          title: item["title"],
          note: item["note_detail"],
          editTime: DateTime.parse(item["edit_time"]),
        ),
      );
    }
    setState(() {
      _registeredNotes = loadedItems;
    });
  }

  @override
  void initState() {
    setState(() {
      _loadItems();
      super.initState();
    });
  }

  void _addNote(Note note) async {
    setState(() {
      _registeredNotes.add(note);
      _registeredNotes.sort((a, b) => b.editTime.compareTo(a.editTime));
    });
  }

  void _editItem(index, Note note) async {
    setState(() {
      _registeredNotes[index] = note;
      _registeredNotes.sort((a, b) => b.editTime.compareTo(a.editTime));
    });
    _loadItems();
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
        title: const Center(
          child: Text(
            "GONote",
          ),
        ),
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
