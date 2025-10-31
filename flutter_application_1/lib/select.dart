import 'package:flutter/material.dart';
import 'add.dart';
import 'view.dart';

class SelectPage extends StatelessWidget {
  const SelectPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset('lib/images/GEOvibe background2.png', fit: BoxFit.cover),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildStyledButton(
                  text: 'Dodaj',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const AddPage()),
                    );
                  },
                ),
                const SizedBox(height: 20),
                _buildStyledButton(
                  text: 'Przypomnij to',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const ViewPage()),
                    );
                  },
                ),
              ],
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
      width: 180,
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
          padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
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
