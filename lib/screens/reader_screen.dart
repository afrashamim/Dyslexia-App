import 'package:flutter/material.dart';

class ReaderScreen extends StatefulWidget {
  const ReaderScreen({super.key});

  @override
  State<ReaderScreen> createState() => _ReaderScreenState();
}

class _ReaderScreenState extends State<ReaderScreen> {
  final TextEditingController controller = TextEditingController();

  String displayedText = '';

  double fontSize = 20;
  double lineHeight = 1.8;
  double letterSpacing = 0.5;

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
          'Reading',
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
            // Text input
            TextField(
              controller: controller,
              maxLines: 6,

              style: const TextStyle(
                fontFamily: 'OpenDyslexic3',
                fontSize: 17,
                color: Color(0xFF302B27),
              ),

              decoration: InputDecoration(
                hintText: 'Paste or type your text here...',

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

            // Show button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    displayedText = controller.text;
                  });
                },

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

                child: const Text(
                  'Show Text',
                  style: TextStyle(
                    fontFamily: 'OpenDyslexic3',
                    fontSize: 17,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Reading controls
            Container(
              padding: const EdgeInsets.all(16),

              decoration: BoxDecoration(
                color: const Color(0xFFE9E3D8),
                borderRadius: BorderRadius.circular(12),
              ),

              child: Column(
                children: [
                  // Font size
                  Row(
                    children: [
                      const Text(
                        'Font',
                        style: TextStyle(
                          fontFamily: 'OpenDyslexic3',
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF3E352D),
                        ),
                      ),

                      Expanded(
                        child: Slider(
                          min: 16,
                          max: 32,
                          value: fontSize,

                          onChanged: (value) {
                            setState(() {
                              fontSize = value;
                            });
                          },
                        ),
                      ),

                      Text(
                        fontSize.round().toString(),
                        style: const TextStyle(
                          fontFamily: 'OpenDyslexic3',
                        ),
                      ),
                    ],
                  ),

                  // Line spacing
                  Row(
                    children: [
                      const Text(
                        'Spacing',
                        style: TextStyle(
                          fontFamily: 'OpenDyslexic3',
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF3E352D),
                        ),
                      ),

                      Expanded(
                        child: Slider(
                          min: 1.2,
                          max: 2.5,
                          value: lineHeight,

                          onChanged: (value) {
                            setState(() {
                              lineHeight = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),

                  // Letter spacing
                  Row(
                    children: [
                      const Text(
                        'Letters',
                        style: TextStyle(
                          fontFamily: 'OpenDyslexic3',
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF3E352D),
                        ),
                      ),

                      Expanded(
                        child: Slider(
                          min: 0,
                          max: 3,
                          value: letterSpacing,

                          onChanged: (value) {
                            setState(() {
                              letterSpacing = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Displayed reading text
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
                    displayedText.isEmpty
                        ? 'Your text will appear here...'
                        : displayedText,

                    textAlign: TextAlign.left,

                    style: TextStyle(
                      fontFamily: 'OpenDyslexic3',
                      fontSize: fontSize,
                      height: lineHeight,
                      letterSpacing: letterSpacing,
                      color: const Color(0xFF302B27),
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