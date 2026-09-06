import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const ReadEaseApp());
}

class ReadEaseApp extends StatelessWidget {
  const ReadEaseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ReadEase',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF7F5EF),
      ),
      home: const HomePage(),
    );
  }
}