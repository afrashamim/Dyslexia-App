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

  Widget _controlRow(
    String label,
    double value,
    double min,
    double max,
    ValueChanged<double> onChanged,
  ) {
    return Row(
      children: [
        SizedBox(
          width: 72,
          child: Text(
            label,
            style: const TextStyle(
              fontFamily: kAppFont,
              fontWeight: FontWeight.w700,
              fontSize: 14,
              color: AppColors.ink,
            ),
          ),
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
      resizeToAvoidBottomInset: true,

      appBar: AppBar(
        title: const Text('Reading'),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          keyboardDismissBehavior:
              ScrollViewKeyboardDismissBehavior.onDrag,
          padding: const EdgeInsets.all(16),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // =====================================================
              // TEXT INPUT
              // =====================================================

              TextField(
                controller: controller,
                maxLines: 6,
                style: const TextStyle(
                  fontFamily: kAppFont,
                  fontSize: 17,
                  color: AppColors.ink,
                ),
                decoration: const InputDecoration(
                  hintText: 'Paste or type your text here...',
                ),
              ),

              const SizedBox(height: 14),

              // =====================================================
              // SHOW TEXT BUTTON
              // =====================================================

              SizedBox(
                width: double.infinity,
                height: 64,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      displayedText = controller.text;
                    });

                    // Hide keyboard after pressing Show Text
                    FocusScope.of(context).unfocus();
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: const Size(
                      double.infinity,
                      64,
                    ),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: const Text(
                    'Show text',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: kAppFont,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      height: 1.2,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // =====================================================
              // READING CONTROLS
              // =====================================================

              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.grape.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(20),
                ),

                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // -----------------------------------------------
                    // SLIDERS
                    // -----------------------------------------------

                    Expanded(
                      child: Column(
                        children: [
                          _controlRow(
                            'Size',
                            fontSize,
                            16,
                            32,
                            (value) {
                              setState(() {
                                fontSize = value;
                              });
                            },
                          ),

                          _controlRow(
                            'Spacing',
                            lineHeight,
                            1.2,
                            2.5,
                            (value) {
                              setState(() {
                                lineHeight = value;
                              });
                            },
                          ),

                          _controlRow(
                            'Letters',
                            letterSpacing,
                            0,
                            3,
                            (value) {
                              setState(() {
                                letterSpacing = value;
                              });
                            },
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(width: 8),

                    // -----------------------------------------------
                    // Aa PREVIEW
                    // -----------------------------------------------

                    AnimatedDefaultTextStyle(
                      duration: const Duration(milliseconds: 120),

                      style: TextStyle(
                        fontFamily: kAppFont,
                        fontSize: fontSize,
                        color: AppColors.grape,
                        fontWeight: FontWeight.w700,
                      ),

                      child: const Text('Aa'),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // =====================================================
              // READING PREVIEW
              // =====================================================

              Container(
                width: double.infinity,
                constraints: const BoxConstraints(
                  minHeight: 250,
                ),

                padding: const EdgeInsets.all(20),

                decoration: BoxDecoration(
                  color: AppColors.readingPaper,
                  borderRadius: BorderRadius.circular(20),
                ),

                child: Text(
                  displayedText.isEmpty
                      ? 'Your text will appear here...'
                      : displayedText,

                  textAlign: TextAlign.left,

                  style: TextStyle(
                    fontFamily: kAppFont,
                    fontSize: fontSize,
                    height: lineHeight,
                    letterSpacing: letterSpacing,
                    color: AppColors.ink,
                  ),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}