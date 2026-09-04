import 'package:flutter/material.dart';

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

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController controller = TextEditingController();

  String displayedText = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dyslexia Reader'),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),

        child: Column(
          children: [

            // Text input box
            TextField(
              controller: controller,
              maxLines: 8,

              decoration: InputDecoration(
                hintText: 'Paste or type your text here...',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Show button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    displayedText = controller.text;
                  });
                },
                child: const Text('Show'),
              ),
            ),

            const SizedBox(height: 20),

            // Displayed dyslexia-friendly text
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

                    style: const TextStyle(
                      fontFamily: 'OpenDyslexic3',
                      fontSize: 20,
                      height: 1.8,
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