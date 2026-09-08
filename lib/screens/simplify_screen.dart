import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
      backgroundColor: const Color(0xFFF7F5EF),

      appBar: AppBar(
        backgroundColor: const Color(0xFFF7F5EF),
        elevation: 0,
        title: const Text(
          'Simplify',
          style: TextStyle(
            fontFamily: 'OpenDyslexic3',
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xFF3E352D),
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          children: [
            TextField(
              controller: controller,
              maxLines: 7,

              style: const TextStyle(
                fontFamily: 'OpenDyslexic3',
                fontSize: 17,
                color: Color(0xFF302B27),
              ),

              decoration: InputDecoration(
                hintText: 'Enter a difficult sentence here...',

                hintStyle: const TextStyle(
                  fontFamily: 'OpenDyslexic3',
                  color: Color(0xFF80776E),
                ),

                filled: true,
                fillColor: Colors.white,

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 14),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: isLoading ? null : simplifyText,

                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF5A4A3D),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    vertical: 14,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),

                child: Text(
                  isLoading ? 'Simplifying...' : 'Simplify Text',
                  style: const TextStyle(
                    fontFamily: 'OpenDyslexic3',
                    fontSize: 17,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  width: double.infinity,

                  padding: const EdgeInsets.all(20),

                  decoration: BoxDecoration(
                    color: const Color(0xFFFFFDF5),
                    borderRadius: BorderRadius.circular(12),
                  ),

                  child: Text(
                    simplifiedText.isEmpty
                        ? 'Your simplified text will appear here...'
                        : simplifiedText,

                    style: const TextStyle(
                      fontFamily: 'OpenDyslexic3',
                      fontSize: 20,
                      height: 1.8,
                      letterSpacing: 0.5,
                      color: Color(0xFF302B27),
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