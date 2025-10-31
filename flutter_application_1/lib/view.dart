import 'package:flutter/material.dart';
import 'notes_data.dart';

class ViewPage extends StatelessWidget {
  const ViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Przypomnij ważne miejsca 📍')),
      body: ListView.builder(
        itemCount: notes.length,
        itemBuilder: (context, index) {
          final note = notes[index];
          return ListTile(
            title: Text(note.text),
            subtitle: Text(
              'Szerokość: ${note.latitude}, Długość: ${note.longitude}',
            ),
          );
        },
      ),
    );
  }
}
