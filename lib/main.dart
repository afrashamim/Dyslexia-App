import 'package:flutter/material.dart';
import 'screens/reader_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dyslexia Reader',

      theme: ThemeData(
        fontFamily: 'OpenDyslexic3',
        scaffoldBackgroundColor: const Color(0xFFF8F5E6),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6B705C),
        ),
      ),

      home: const MyHomePage(),
    );
  }
}