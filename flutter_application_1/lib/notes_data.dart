import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class Note {
  final String text;
  final double latitude;
  final double longitude;

  Note({required this.text, required this.latitude, required this.longitude});

  Map<String, dynamic> toMap() => {
    'text': text,
    'latitude': latitude,
    'longitude': longitude,
  };

  factory Note.fromMap(Map<String, dynamic> map) => Note(
    text: map['text'],
    latitude: map['latitude'],
    longitude: map['longitude'],
  );
}

List<Note> notes = [];

Future<void> saveNotes() async {
  final prefs = await SharedPreferences.getInstance();
  final encoded = jsonEncode(notes.map((n) => n.toMap()).toList());
  await prefs.setString('notes', encoded);
}

Future<void> loadNotes() async {
  final prefs = await SharedPreferences.getInstance();
  final jsonString = prefs.getString('notes');
  if (jsonString == null) return;
  final List decoded = jsonDecode(jsonString);
  notes = decoded.map((e) => Note.fromMap(e)).toList();
}
