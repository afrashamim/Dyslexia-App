import 'package:flutter/material.dart';

class FeatureCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final VoidCallback onTap;

  const FeatureCard({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(
                fontFamily: 'OpenDyslexic3',
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: const TextStyle(
                fontFamily: 'OpenDyslexic3',
                fontSize: 15,
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: onTap,
              child: const Text(
                'Open',
                style: TextStyle(
                  fontFamily: 'OpenDyslexic3',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}