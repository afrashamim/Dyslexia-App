import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../theme/app_theme.dart';

class SimplifyScreen extends StatefulWidget {
  const SimplifyScreen({super.key});

  @override
  State<SimplifyScreen> createState() => _SimplifyScreenState();
}

class _SimplifyScreenState extends State<SimplifyScreen> {
  final TextEditingController controller = TextEditingController();

  String simplifiedText = '';
  bool isLoading = false;

  Future<void> simplifyText() async {
    if (controller.text.trim().isEmpty) {
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      final response = await http.post(
        Uri.parse('http://127.0.0.1:5000/simplify'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'text': controller.text,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        setState(() {
          simplifiedText = data['simplifiedText'];
        });
      } else {
        setState(() {
          simplifiedText = 'Unable to simplify the text.';
        });
      }
    } catch (e) {
      setState(() {
        simplifiedText =
            'Could not connect to the backend. Make sure Flask is running.';
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Simplify'),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          children: [
            // Input text
            TextField(
              controller: controller,
              maxLines: 7,

              style: const TextStyle(
                fontFamily: kAppFont,
                fontSize: 17,
                color: AppColors.ink,
              ),

              decoration: const InputDecoration(
                hintText: 'Enter a difficult sentence here...',
              ),
            ),

            const SizedBox(height: 14),

            // Simplify button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: isLoading ? null : simplifyText,

                child: Text(
                  isLoading ? 'Simplifying...' : 'Simplify Text',
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Simplified text
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  width: double.infinity,

                  padding: const EdgeInsets.all(20),

                  decoration: BoxDecoration(
                    color: AppColors.displayBox,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: AppColors.paperDeep,
                      width: 1.5,
                    ),
                  ),

                  child: Text(
                    simplifiedText.isEmpty
                        ? 'Your simplified text will appear here...'
                        : simplifiedText,

                    style: const TextStyle(
                      fontFamily: kAppFont,
                      fontSize: 20,
                      height: 1.8,
                      letterSpacing: 0.5,
                      color: AppColors.ink,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}