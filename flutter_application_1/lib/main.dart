import 'package:flutter/material.dart';
import 'select.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GeoVibe',
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset('lib/images/Geovibe background2.png', fit: BoxFit.cover),

          Center(
            child: SizedBox(
              width: 150,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(
                    context,
                  ).push(MaterialPageRoute(builder: (_) => const SelectPage()));
                },

                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,

                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(24),
                    side: const BorderSide(color: Color(0xFF3A3A3A), width: 1),
                  ),

                  padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                ),
                child: const Text(
                  'Zacznij 🚀',
                  style: TextStyle(
                    color: Color(0xFF3A3A3A),
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
