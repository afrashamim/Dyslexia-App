import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

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

  Widget _controlRow(String label, double value, double min, double max,
      ValueChanged<double> onChanged) {
    return Row(
      children: [
        SizedBox(
          width: 64,
          child: Text(label,
              style: const TextStyle(
                  fontWeight: FontWeight.w600, color: AppColors.ink)),
        ),
        Expanded(
          child: Slider(
            min: min,
            max: max,
            value: value,
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Reading')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: controller,
              maxLines: 6,
              style: const TextStyle(fontSize: 17, color: AppColors.ink),
              decoration: const InputDecoration(
                hintText: 'Paste or type your text here...',
              ),
            ),
            const SizedBox(height: 14),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => setState(() => displayedText = controller.text),
                child: const Text('Show Text'),
              ),
            ),
            const SizedBox(height: 16),

            // Reading controls — live "Aa" preview grows with font size
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.paperDeep,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        _controlRow('Size', fontSize, 16, 32,
                            (v) => setState(() => fontSize = v)),
                        _controlRow('Spacing', lineHeight, 1.2, 2.5,
                            (v) => setState(() => lineHeight = v)),
                        _controlRow('Letters', letterSpacing, 0, 3,
                            (v) => setState(() => letterSpacing = v)),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  AnimatedDefaultTextStyle(
                    duration: const Duration(milliseconds: 120),
                    style: TextStyle(
                      fontFamily: kAppFont,
                      fontSize: fontSize,
                      color: AppColors.moss,
                      fontWeight: FontWeight.w700,
                    ),
                    child: const Text('Aa'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppColors.displayBox,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppColors.paperDeep, width: 1.5),
                  ),
                  child: Text(
                    displayedText.isEmpty
                        ? 'Your text will appear here...'
                        : displayedText,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: fontSize,
                      height: lineHeight,
                      letterSpacing: letterSpacing,
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