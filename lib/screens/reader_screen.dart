import 'package:flutter/material.dart';

class ReadingScreen extends StatelessWidget {
  const ReadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Reading',
          style: TextStyle(
            fontFamily: 'OpenDyslexic3',
          ),
        ),
      ),

      body: const Center(
        child: Text(
          'Reading Screen',
          style: TextStyle(
            fontFamily: 'OpenDyslexic3',
            fontSize: 24,
          ),
        ),
      ),
    );
  }
}