import 'package:flutter/material.dart';

import 'listen_drag_game.dart';
import 'build_word_game.dart';
import 'hear_word_game.dart';

class PhonicsScreen extends StatelessWidget {
  const PhonicsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Phonics'),
        centerTitle: true,
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),

          child: Column(
            children: [
              const SizedBox(height: 10),

              const Text(
                'Choose a Game',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 30),

              // ------------------------------------------------
              // GAME 1 - LISTEN & DRAG
              // ------------------------------------------------

              SizedBox(
                width: double.infinity,
                height: 120,

                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const ListenDragGame(),
                      ),
                    );
                  },

                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [
                      Icon(
                        Icons.volume_up,
                        size: 35,
                      ),

                      SizedBox(height: 8),

                      Text(
                        'Listen & Drag',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // ------------------------------------------------
              // GAME 2 - BUILD THE WORD
              // ------------------------------------------------

              SizedBox(
                width: double.infinity,
                height: 120,

                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const BuildWordGame(),
                      ),
                    );
                  },

                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [
                      Icon(
                        Icons.extension,
                        size: 35,
                      ),

                      SizedBox(height: 8),

                      Text(
                        'Build the Word',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // ------------------------------------------------
              // GAME 3 - HEAR & CHOOSE
              // ------------------------------------------------

              SizedBox(
                width: double.infinity,
                height: 120,

                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const HearWordGame(),
                      ),
                    );
                  },

                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [
                      Icon(
                        Icons.hearing,
                        size: 35,
                      ),

                      SizedBox(height: 8),

                      Text(
                        'Hear & Choose',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}