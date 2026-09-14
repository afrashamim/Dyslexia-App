import 'package:flutter/material.dart';
import 'listen_drag_game.dart';
import 'build_word_game.dart';

class PhonicsScreen extends StatelessWidget {
  const PhonicsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Phonics'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text(
              'Choose a Game',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 30),

            // Game 1
            SizedBox(
              width: double.infinity,
              height: 120,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ListenDragGame(),
                    ),
                  );
                },
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.volume_up, size: 35),
                    SizedBox(height: 8),
                    Text(
                      'Listen & Drag',
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Game 2
            SizedBox(
              width: double.infinity,
              height: 120,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const BuildWordGame(),
                    ),
                  );
                },
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.extension, size: 35),
                    SizedBox(height: 8),
                    Text(
                      'Build the Word',
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}