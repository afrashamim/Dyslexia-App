import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

class BuildWordGame extends StatefulWidget {
  const BuildWordGame({super.key});

  @override
  State<BuildWordGame> createState() => _BuildWordGameState();
}

class _BuildWordGameState extends State<BuildWordGame> {
  // How many words to play in one round.
  static const int roundLength = 4;

  // All words loaded from assets/words.json, grouped by category.
  Map<String, List<Map<String, String>>> wordsByCategory = {};
  bool isLoading = true;

  // Which categories are currently included in the pool.
  Set<String> selectedCategories = {};

  int wordIndex = 0;
  int score = 0;

  late List<Map<String, String>> words;
  late List<String> availableLetters;
  List<String> selectedLetters = [];

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
          .map((e) => {
                'word': (e['word'] as String).toUpperCase(),
                'hint': e['hint'] as String,
              })
          .toList();
    });

    setState(() {
      wordsByCategory = parsed;
      selectedCategories = parsed.keys.toSet(); // default: all categories
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
          showFinalScore();
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

  void showFinalScore() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: const Text('Game Complete! 🎉'),
          content: Text(
            'Your score is $score / ${words.length * 10}',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                setState(() {
                  startNewRound();
                });
              },
              child: const Text('Play Again'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                openCategoryPicker();
              },
              child: const Text('Change Categories'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: const Text('Exit'),
            ),
          ],
        );
      },
    );
  }

  void openCategoryPicker() {
    final tempSelection = Set<String>.from(selectedCategories);

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: const Text('Choose Categories'),
              content: SizedBox(
                width: double.maxFinite,
                child: ListView(
                  shrinkWrap: true,
                  children: wordsByCategory.keys.map((category) {
                    return CheckboxListTile(
                      title: Text(category),
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
                  child: const Text('Cancel'),
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
                  child: const Text('Start'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  // Calculates a tile size that keeps all selected letters on a single line,
  // shrinking as words get longer so the "Your word" box never overflows.
  double _tileSizeFor(double availableWidth, int letterCount) {
    const maxTileSize = 65.0;
    const minTileSize = 34.0;
    const margin = 12.0; // 6px margin on each side of a tile

    if (letterCount == 0) return maxTileSize;

    final sizeThatFits = (availableWidth / letterCount) - margin;
    return sizeThatFits.clamp(minTileSize, maxTileSize);
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final currentWord = words[wordIndex];

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
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            LinearProgressIndicator(
              value: (wordIndex + 1) / words.length,
              minHeight: 10,
            ),

            const SizedBox(height: 15),

            Text(
              'Word ${wordIndex + 1} of ${words.length}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 35),

            const Text(
              'Build the word',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            Text(
              currentWord['hint'] as String,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 18,
              ),
            ),

            const SizedBox(height: 35),

            const Text(
              'Your word',
              style: TextStyle(fontSize: 18),
            ),

            const SizedBox(height: 15),

            Container(
              width: double.infinity,
              height: 90,
              padding: const EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                border: Border.all(width: 2),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Center(
                child: selectedLetters.isEmpty
                    ? const Text(
                        'Tap the letters below',
                        style: TextStyle(
                          fontSize: 16,
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

            const SizedBox(height: 40),

            const Text(
              'Choose the letters',
              style: TextStyle(fontSize: 18),
            ),

            const SizedBox(height: 20),

            Wrap(
              alignment: WrapAlignment.center,
              children: availableLetters.map((letter) {
                return GestureDetector(
                  onTap: () => selectLetter(letter),
                  child: LetterTile(letter: letter),
                );
              }).toList(),
            ),

            const SizedBox(height: 40),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: selectedLetters.isEmpty ? null : checkWord,
                child: const Text(
                  'Check Answer',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),

            const Spacer(),

            Text(
              'Score: $score',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
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
      margin: const EdgeInsets.symmetric(horizontal: 6),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(width: 2),
      ),
      child: Text(
        letter,
        style: TextStyle(
          fontSize: size * 0.46,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}