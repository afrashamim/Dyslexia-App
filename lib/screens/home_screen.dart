import 'package:flutter/material.dart';
import '../widgets/feature_card.dart';
import '../widgets/wave_clipper.dart';
import 'reader_screen.dart';
import 'simplify_screen.dart';
import '../tts/tts_testscreen.dart';
import '../phonics/phonics_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.skyMist,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // ---------------- WAVE HEADER + MASCOT ----------------
              Stack(
                clipBehavior: Clip.none,
                children: [
                  ClipPath(
                    clipper: WaveClipper(),
                    child: Container(
                      height: 130,
                      width: double.infinity,
                      color: AppColors.sunshine,
                    ),
                  ),
                  const Positioned(
                      top: 14, left: 20, child: Text('✨', style: TextStyle(fontSize: 15))),
                  const Positioned(
                      top: 6, right: 26, child: Text('✨', style: TextStyle(fontSize: 13))),
                  const Positioned(
                      top: 74, right: 18, child: Text('⭐', style: TextStyle(fontSize: 13))),
                  Positioned(
                    top: 34,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Container(
                        width: 68,
                        height: 68,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(color: const Color(0xFF412402), width: 3),
                        ),
                        alignment: Alignment.center,
                        child: const Text('🦉', style: TextStyle(fontSize: 34)),
                      ),
                    ),
                  ),
                ],
              ),

              // ---------------- CONTENT ----------------
              Padding(
                padding: const EdgeInsets.fromLTRB(22, 8, 22, 22),
                child: Column(
                  children: [
                    Text('Hi, friend!', style: Theme.of(context).textTheme.headlineMedium),
                    const SizedBox(height: 4),
                    Text(
                      'What do you want to do today?',
                      style: Theme.of(context).textTheme.bodyLarge,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),

                    FeatureCard(
                      icon: Icons.menu_book_rounded,
                      title: 'Read',
                      description: 'Read in a comfy, easy way',
                      color: AppColors.grass,
                      shadowColor: const Color(0xFF04342C),
                      radius: BorderRadius.circular(20).copyWith(
                        topRight: const Radius.circular(14),
                        bottomRight: const Radius.circular(14),
                      ),
                      tilt: -0.02,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const ReaderScreen()),
                        );
                      },
                    ),
                    const SizedBox(height: 20),

                    FeatureCard(
                      icon: Icons.volume_up_rounded,
                      title: 'Read aloud',
                      description: 'Listen to the words',
                      color: AppColors.coral,
                      shadowColor: const Color(0xFF4A1B0C),
                      radius: BorderRadius.circular(20).copyWith(
                        topLeft: const Radius.circular(14),
                        bottomLeft: const Radius.circular(14),
                      ),
                      tilt: 0.02,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const TtsTestScreen()),
                        );
                      },
                    ),
                    const SizedBox(height: 20),

                    FeatureCard(
                      icon: Icons.auto_awesome_rounded,
                      title: 'Simplify',
                      description: 'Make tricky words easy',
                      color: AppColors.grape,
                      shadowColor: const Color(0xFF26215C),
                      textColor: Colors.white,
                      descColor: const Color(0xFFEEEDFE),
                      radius: BorderRadius.circular(20).copyWith(
                        topRight: const Radius.circular(14),
                        bottomRight: const Radius.circular(14),
                      ),
                      tilt: -0.02,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const SimplifyScreen()),
                        );
                      },
                    ),
                    const SizedBox(height: 20),

                    FeatureCard(
                      icon: Icons.extension_rounded,
                      title: 'Phonics game',
                      description: 'Play and practice sounds',
                      color: AppColors.sunshine,
                      shadowColor: const Color(0xFF412402),
                      radius: BorderRadius.circular(20).copyWith(
                        topLeft: const Radius.circular(14),
                        bottomLeft: const Radius.circular(14),
                      ),
                      tilt: 0.02,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const PhonicsScreen()),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}