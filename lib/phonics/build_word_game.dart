import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

import '../theme/app_theme.dart';

class BuildWordGame extends StatefulWidget {
  const BuildWordGame({super.key});

  @override
  State<BuildWordGame> createState() => _BuildWordGameState();
}

class _BuildWordGameState extends State<BuildWordGame> {
  static const int roundLength = 4;

  Map<String, List<Map<String, String>>> wordsByCategory = {};
  bool isLoading = true;

  Set<String> selectedCategories = {};

  int wordIndex = 0;
  int score = 0;

  late List<Map<String, String>> words;
  late List<String> availableLetters;

  List<String> selectedLetters = [];

  bool gameFinished = false;

  @override
  void initState() {
    super.initState();
    loadWords();
  }

  Future<void> loadWords() async {
    final raw = await rootBundle.loadString('assets/words.json');
    final Map<String, dynamic> decoded = jsonDecode(raw);

    final parsed = <String, List<Map<String, String>>>{};

    decoded.forEach((category, entries) {
      parsed[category] = (entries as List)
          .map(
            (e) => {
              'word': (e['word'] as String).toUpperCase(),
              'hint': e['hint'] as String,
            },
          )
          .toList();
    });

    setState(() {
      wordsByCategory = parsed;
      selectedCategories = parsed.keys.toSet();
      isLoading = false;
    });

    startNewRound();
  }

  List<Map<String, String>> get _activePool {
    final pool = <Map<String, String>>[];

    for (final category in selectedCategories) {
      pool.addAll(wordsByCategory[category] ?? []);
    }

    return pool;
  }

  void startNewRound() {
    final pool = _activePool;

    if (pool.isEmpty) return;

    final shuffled = List<Map<String, String>>.from(pool)..shuffle();

    words = shuffled.take(min(roundLength, pool.length)).toList();

    wordIndex = 0;
    score = 0;
    gameFinished = false;

    prepareLetters();
  }

  void prepareLetters() {
    availableLetters =
        (words[wordIndex]['word'] as String).split('')..shuffle();

    selectedLetters = [];
  }

  void selectLetter(String letter) {
    setState(() {
      selectedLetters.add(letter);
      availableLetters.remove(letter);
    });
  }

  void removeLetter(int index) {
    setState(() {
      final letter = selectedLetters.removeAt(index);
      availableLetters.add(letter);
    });
  }

  void checkWord() {
    final correctWord = words[wordIndex]['word'] as String;
    final enteredWord = selectedLetters.join();

    if (enteredWord == correctWord) {
      setState(() {
        score += 10;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Excellent! 🎉'),
          duration: Duration(milliseconds: 800),
        ),
      );

      Future.delayed(const Duration(milliseconds: 900), () {
        if (!mounted) return;

        if (wordIndex < words.length - 1) {
          setState(() {
            wordIndex++;
            prepareLetters();
          });
        } else {
          setState(() {
            gameFinished = true;
          });
        }
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Not quite! Try again.'),
          duration: Duration(milliseconds: 800),
        ),
      );
    }
  }

  void playAgain() {
    setState(() {
      startNewRound();
    });
  }

  void openCategoryPicker() {
    final tempSelection = Set<String>.from(selectedCategories);

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: const Text(
                'Choose Categories',
                style: TextStyle(
                  fontFamily: kAppFont,
                  fontWeight: FontWeight.bold,
                ),
              ),
              content: SizedBox(
                width: double.maxFinite,
                child: ListView(
                  shrinkWrap: true,
                  children: wordsByCategory.keys.map((category) {
                    return CheckboxListTile(
                      title: Text(
                        category,
                        style: const TextStyle(
                          fontFamily: kAppFont,
                        ),
                      ),
                      value: tempSelection.contains(category),
                      onChanged: (checked) {
                        setDialogState(() {
                          if (checked == true) {
                            tempSelection.add(category);
                          } else {
                            tempSelection.remove(category);
                          }
                        });
                      },
                    );
                  }).toList(),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text(
                    'Cancel',
                    style: TextStyle(
                      fontFamily: kAppFont,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: tempSelection.isEmpty
                      ? null
                      : () {
                          setState(() {
                            selectedCategories = tempSelection;
                          });

                          Navigator.pop(context);
                          startNewRound();
                        },
                  child: const Text(
                    'Start',
                    style: TextStyle(
                      fontFamily: kAppFont,
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  double _tileSizeFor(double availableWidth, int letterCount) {
    const maxTileSize = 65.0;
    const minTileSize = 34.0;
    const margin = 12.0;

    if (letterCount == 0) {
      return maxTileSize;
    }

    final sizeThatFits = (availableWidth / letterCount) - margin;

    return sizeThatFits.clamp(
      minTileSize,
      maxTileSize,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Build the Word'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.tune),
            tooltip: 'Choose categories',
            onPressed: openCategoryPicker,
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 18,
            vertical: 10,
          ),
          child: gameFinished
              ? buildCompletedScreen()
              : buildGameScreen(),
        ),
      ),
    );
  }

  Widget buildGameScreen() {
    final currentWord = words[wordIndex];

    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 15),

          LinearProgressIndicator(
            value: (wordIndex + 1) / words.length,
            minHeight: 8,
            borderRadius: BorderRadius.circular(10),
          ),

          const SizedBox(height: 10),

          Text(
            'Word ${wordIndex + 1} of ${words.length}',
            style: TextStyle(
              fontFamily: kAppFont,
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: AppColors.ink,
            ),
          ),

          const SizedBox(height: 28),

          Text(
            'Build the word',
            style: TextStyle(
              fontFamily: kAppFont,
              fontSize: 23,
              fontWeight: FontWeight.bold,
              color: AppColors.ink,
            ),
          ),

          const SizedBox(height: 12),

          Text(
            currentWord['hint'] as String,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: kAppFont,
              fontSize: 16,
              color: AppColors.ink,
            ),
          ),

          const SizedBox(height: 28),

          Text(
            'Your word',
            style: TextStyle(
              fontFamily: kAppFont,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.ink,
            ),
          ),

          const SizedBox(height: 12),

          Container(
            width: double.infinity,
            height: 90,
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
            ),
            decoration: BoxDecoration(
              color: AppColors.readingPaper,
              border: Border.all(width: 2),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Center(
              child: selectedLetters.isEmpty
                  ? Text(
                      'Tap the letters below',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: kAppFont,
                        fontSize: 16,
                        color: AppColors.inkFaded,
                      ),
                    )
                  : LayoutBuilder(
                      builder: (context, constraints) {
                        final tileSize = _tileSizeFor(
                          constraints.maxWidth,
                          selectedLetters.length,
                        );

                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:
                              selectedLetters.asMap().entries.map((entry) {
                            final index = entry.key;
                            final letter = entry.value;

                            return GestureDetector(
                              onTap: () => removeLetter(index),
                              child: LetterTile(
                                letter: letter,
                                size: tileSize,
                              ),
                            );
                          }).toList(),
                        );
                      },
                    ),
            ),
          ),

          const SizedBox(height: 32),

          Text(
            'Choose the letters',
            style: TextStyle(
              fontFamily: kAppFont,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.ink,
            ),
          ),

          const SizedBox(height: 18),

          Wrap(
            alignment: WrapAlignment.center,
            spacing: 4,
            runSpacing: 10,
            children: availableLetters.map((letter) {
              return GestureDetector(
                onTap: () => selectLetter(letter),
                child: LetterTile(
                  letter: letter,
                ),
              );
            }).toList(),
          ),

          const SizedBox(height: 32),

          SizedBox(
            width: double.infinity,
            height: 68,
            child: ElevatedButton(
              onPressed:
                  selectedLetters.isEmpty ? null : checkWord,
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: const Size(
                  double.infinity,
                  68,
                ),
                tapTargetSize:
                    MaterialTapTargetSize.shrinkWrap,
              ),
              child: Text(
                'Check Answer',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: kAppFont,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  height: 1.2,
                ),
              ),
            ),
          ),

          const SizedBox(height: 18),

          Text(
            'Score: $score',
            style: TextStyle(
              fontFamily: kAppFont,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.ink,
            ),
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }

  // ----------------------------------------------------------
  // COMPLETED SCREEN
  // Same style as Hear & Choose
  // ----------------------------------------------------------

  Widget buildCompletedScreen() {
    return SingleChildScrollView(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height - 140,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 50),

            const Icon(
              Icons.celebration_outlined,
              size: 70,
            ),

            const SizedBox(height: 20),

            Text(
              'Great job! 🎉',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: kAppFont,
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: AppColors.ink,
              ),
            ),

            const SizedBox(height: 12),

            Text(
              'You completed all ${words.length} questions!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: kAppFont,
                fontSize: 18,
                color: AppColors.ink,
              ),
            ),

            const SizedBox(height: 20),

            Text(
              'Final Score: $score / ${words.length * 10}',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: kAppFont,
                fontSize: 21,
                fontWeight: FontWeight.bold,
                color: AppColors.ink,
              ),
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              height: 68,
              child: ElevatedButton(
                onPressed: playAgain,
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: const Size(
                    double.infinity,
                    68,
                  ),
                  tapTargetSize:
                      MaterialTapTargetSize.shrinkWrap,
                ),
                child: Text(
                  'Play Again',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: kAppFont,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    height: 1.2,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}

class LetterTile extends StatelessWidget {
  final String letter;
  final double size;

  const LetterTile({
    super.key,
    required this.letter,
    this.size = 65,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      margin: const EdgeInsets.symmetric(
        horizontal: 6,
      ),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.readingPaper,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(width: 2),
      ),
      child: Text(
        letter,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontFamily: kAppFont,
          fontSize: size * 0.46,
          fontWeight: FontWeight.bold,
          color: AppColors.ink,
        ),
      ),
    );
  }
}