import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'notes_data.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final TextEditingController _controller = TextEditingController();
  double? latitude;
  double? longitude;

  @override
  void initState() {
    super.initState();
    loadNotes();
  }

  Future<void> _getLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Znajdź miejsce 🧭')));
      return;
    }
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) return;
    }

    if (permission == LocationPermission.deniedForever) return;

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    setState(() {
      latitude = position.latitude;
      longitude = position.longitude;
    });
  }

  void _saveNote() async {
    if (_controller.text.isEmpty || latitude == null || longitude == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Nie zapomnij napisać swoich emocji i współrzędnych💖'),
        ),
      );
      return;
    }

    notes.add(
      Note(text: _controller.text, latitude: latitude!, longitude: longitude!),
    );
    await saveNotes();

    _controller.clear();
    setState(() {
      latitude = null;
      longitude = null;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Zachowaliśmy Twoje wspomnienie ✅')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dodaj miejsce📍')),

      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset('lib/images/GEOvibe background2.png', fit: BoxFit.cover),
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildStyledButton(
                    text: 'Twoje współrzędne',
                    onPressed: _getLocation,
                  ),
                  const SizedBox(height: 10),
                  if (latitude != null && longitude != null)
                    Text(
                      'Szerokość: $latitude\nDługość: $longitude',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Color(0xFF3A3A3A),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.9),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: Color(0xFF3A3A3A),
                          width: 1,
                        ),
                      ),
                      labelText: 'Napisz, co czujesz',
                      labelStyle: const TextStyle(
                        color: Color(0xFF3A3A3A),
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildStyledButton(text: 'Zapisz', onPressed: _saveNote),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStyledButton({
    required String text,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: 200,
      height: 50,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
            side: const BorderSide(color: Color(0xFF3A3A3A), width: 1),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(
            color: Color(0xFF3A3A3A),
            fontWeight: FontWeight.w600,
            letterSpacing: 0.0,
          ),
        ),
      ),
    );
  }
}
