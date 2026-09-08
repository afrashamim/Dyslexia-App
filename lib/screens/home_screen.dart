import 'package:flutter/material.dart';
import '../widgets/feature_card.dart';
import 'reader_screen.dart';
import 'simplify_screen.dart';

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

              // ---------------- READ ----------------
              FeatureCard(
                icon: Icons.menu_book,
                title: 'Read',
                description:
                    'Read with a dyslexia-friendly interface.',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ReaderScreen(),
                    ),
                  );
                },
              ),

              const SizedBox(height: 18),

              // ---------------- READ ALOUD ----------------
              FeatureCard(
                icon: Icons.volume_up_outlined,
                title: 'Read Aloud',
                description:
                    'Listen to text being read aloud.',
                onTap: () {
                  // Person B will add TTS navigation here
                },
              ),

              const SizedBox(height: 18),

              // ---------------- SIMPLIFY ----------------
              FeatureCard(
                icon: Icons.auto_awesome_outlined,
                title: 'Simplify',
                description:
                    'Make difficult sentences easier to understand.',
                onTap: () {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => const SimplifyScreen(),
    ),
  );
},
              ),

              const SizedBox(height: 18),

              // ---------------- PHONICS ----------------
              FeatureCard(
                icon: Icons.extension_outlined,
                title: 'Phonics Game',
                description:
                    'Practice letters, sounds and words through games.',
                onTap: () {
                  // Person C will add phonics navigation here
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}