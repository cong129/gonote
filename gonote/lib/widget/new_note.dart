import 'package:flutter/material.dart';
import 'package:gonote/model/note.dart';

class NewNote extends StatelessWidget {
  const NewNote({
    super.key,
    required this.onAddnote,
  });

  final void Function(Note note) onAddnote;

//   @override
//   State<NewNote> createState() => _NewNoteState();
// }

// class _NewNoteState extends State<NewNote> {

  // final _titleController = TextEditingController();
  // final _noteController = TextEditingController();

  // @override
  // void initState(){
  //   super.initState();
  //   _titleController.text =
  // }

  // void _submitNoteData() async {
  //   if (_titleController.text.trim().isEmpty) {
  //     showDialog(
  //       context: context,
  //       builder: (ctx) => AlertDialog(
  //           title: const Text("No Title input"),
  //           content: const Text(
  //             "Please input title.",
  //           ),
  //           actions: [
  //             ElevatedButton(
  //               onPressed: () {
  //                 Navigator.pop(ctx);
  //               },
  //               child: const Text("OK"),
  //             ),
  //           ]),
  //     );
  //     return;
  //   }
  //   widget.onAddnote(
  //     Note(
  //         title: _titleController.text,
  //         note: _noteController.text,
  //         editTime: DateTime.now()),
  //   );
  //   Navigator.pop(context);
  // }

  // @override
  // void dispose() {
  //   _titleController.dispose();
  //   _noteController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController();
    final noteController = TextEditingController();

    void submitNoteData() async {
      if (titleController.text.trim().isEmpty) {
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
              title: const Text("No Title input"),
              content: const Text(
                "Please input title.",
              ),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(ctx);
                  },
                  child: const Text("OK"),
                ),
              ]),
        );
        return;
      }
      // widget.onAddnote(
      onAddnote(
        Note(
            title: titleController.text,
            note: noteController.text,
            editTime: DateTime.now()),
      );
      Navigator.pop(context);
    }

    return SizedBox(
      height: double.infinity,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 40),
          child: Column(children: [
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
            Row(
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Cancel"),
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: submitNoteData,
                  child: const Text("Save Note"),
                ),
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
