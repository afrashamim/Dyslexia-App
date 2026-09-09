import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/feature_card.dart';
import 'reader_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ReadEase'), // styling now comes from appBarTheme
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 15),

              Text(
                'Welcome 👋',
                style: Theme.of(context).textTheme.headlineMedium,
              ),

              const SizedBox(height: 10),

              Text(
                'What would you like to do today?',
                style: Theme.of(context).textTheme.bodyLarge,
              ),

              const SizedBox(height: 30),

              // ---------------- READ ----------------
              FeatureCard(
                icon: Icons.menu_book,
                title: 'Read',
                description: 'Read with a dyslexia-friendly interface.',
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
                description: 'Listen to text being read aloud.',
                onTap: () {
                  // Person B will add TTS navigation here
                },
              ),

              const SizedBox(height: 18),

              // ---------------- SIMPLIFY ----------------
              FeatureCard(
                icon: Icons.auto_awesome_outlined,
                title: 'Simplify',
                description: 'Make difficult sentences easier to understand.',
                onTap: () {
                  // Person D will add simplification navigation here
                },
              ),

              const SizedBox(height: 18),

              // ---------------- PHONICS ----------------
              FeatureCard(
                icon: Icons.extension_outlined,
                title: 'Phonics Game',
                description: 'Practice letters, sounds and words through games.',
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