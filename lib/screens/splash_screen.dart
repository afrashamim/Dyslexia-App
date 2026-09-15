import 'dart:async';
import 'package:flutter/material.dart';
import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double _opacity = 0;
  double _scale = 0.8;

  @override
  void initState() {
    super.initState();

    // Fast appearance — starts almost immediately
    Future.delayed(const Duration(milliseconds: 50), () {
      if (mounted) {
        setState(() {
          _opacity = 1;
          _scale = 1;
        });
      }
    });

    // Hold briefly, then fade into HomeScreen
    Timer(const Duration(milliseconds: 2500), () {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                const HomeScreen(),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return FadeTransition(opacity: animation, child: child);
            },
            transitionDuration: const Duration(milliseconds: 500),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF3D6), // cream, matches the logo badge
      body: Center(
        child: AnimatedOpacity(
          opacity: _opacity,
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
          child: AnimatedScale(
            scale: _scale,
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeOut,
            child: Image.asset(
              'assets/images/learnable_logo.png',
              width: 220,
            ),
          ),
        ),
      ),
    );
  }
}