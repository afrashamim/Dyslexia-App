import 'package:flutter/material.dart';
import '../widgets/feature_card.dart';
import 'reading_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F5EF),

      appBar: AppBar(
        backgroundColor: const Color(0xFFF7F5EF),
        elevation: 0,

        title: const Text(
          'ReadEase',
          style: TextStyle(
            fontFamily: 'OpenDyslexic3',
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Color(0xFF3E352D),
          ),
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              const SizedBox(height: 15),

              const Text(
                'Welcome 👋',
                style: TextStyle(
                  fontFamily: 'OpenDyslexic3',
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF3E352D),
                ),
              ),

              const SizedBox(height: 10),

              const Text(
                'What would you like to do today?',
                style: TextStyle(
                  fontFamily: 'OpenDyslexic3',
                  fontSize: 18,
                  height: 1.5,
                  color: Color(0xFF62584F),
                ),
              ),

              const SizedBox(height: 30),

              // Reading
              FeatureCard(
                icon: Icons.menu_book_outlined,
                title: 'Read',
                description:
                    'Read text in a comfortable, dyslexia-friendly format.',
                buttonText: 'Start Reading',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ReadingScreen(),
                    ),
                  );
                },
              ),

              const SizedBox(height: 18),

              // TTS
              FeatureCard(
                icon: Icons.volume_up_outlined,
                title: 'Read Aloud',
                description:
                    'Listen to text being read aloud.',
                buttonText: 'Open',
                onPressed: () {
                  // Person B will add TTS navigation
                },
              ),

              const SizedBox(height: 18),

              // Simplification
              FeatureCard(
                icon: Icons.auto_awesome_outlined,
                title: 'Simplify',
                description:
                    'Make difficult sentences easier to understand.',
                buttonText: 'Open',
                onPressed: () {
                  // Person D will add simplification navigation
                },
              ),

              const SizedBox(height: 18),

              // Phonics
              FeatureCard(
                icon: Icons.extension_outlined,
                title: 'Phonics Game',
                description:
                    'Practice letters, sounds and words through games.',
                buttonText: 'Play',
                onPressed: () {
                  // Person C will add phonics navigation
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}