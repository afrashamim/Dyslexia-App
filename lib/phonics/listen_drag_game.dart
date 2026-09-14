import 'dart:math';
import 'package:flutter/material.dart';
import '../tts/tts_service.dart';

class ListenDragGame extends StatefulWidget {
  const ListenDragGame({super.key});

  @override
  State<ListenDragGame> createState() => _ListenDragGameState();
}

class _ListenDragGameState extends State<ListenDragGame> {
  final TtsService _ttsService = TtsService();

  int questionIndex = 0;
  int score = 0;

  // Number of questions in each game
  static const int questionsPerGame = 4;

  late List<Map<String, dynamic>> questions;

  // =====================================================
  // PHONICS QUESTION BANK
  // =====================================================

  final List<Map<String, dynamic>> allQuestions = [
    // -------------------------
    // BASIC CONSONANTS
    // -------------------------

    {
      'sound': '/b/',
      'speak': 'buh',
      'answer': 'B',
      'options': ['B', 'D', 'P'],
    },
    {
      'sound': '/d/',
      'speak': 'duh',
      'answer': 'D',
      'options': ['B', 'D', 'P'],
    },
    {
      'sound': '/p/',
      'speak': 'puh',
      'answer': 'P',
      'options': ['B', 'P', 'D'],
    },
    {
      'sound': '/m/',
      'speak': 'mmm',
      'answer': 'M',
      'options': ['N', 'M', 'W'],
    },
    {
      'sound': '/n/',
      'speak': 'nnn',
      'answer': 'N',
      'options': ['M', 'N', 'H'],
    },
    {
      'sound': '/t/',
      'speak': 'tuh',
      'answer': 'T',
      'options': ['T', 'D', 'P'],
    },
    {
      'sound': '/k/',
      'speak': 'kuh',
      'answer': 'C',
      'options': ['G', 'C', 'K'],
    },
    {
      'sound': '/g/',
      'speak': 'guh',
      'answer': 'G',
      'options': ['G', 'C', 'D'],
    },
    {
      'sound': '/f/',
      'speak': 'fff',
      'answer': 'F',
      'options': ['F', 'V', 'S'],
    },
    {
      'sound': '/v/',
      'speak': 'vvv',
      'answer': 'V',
      'options': ['F', 'V', 'W'],
    },
    {
      'sound': '/s/',
      'speak': 'sss',
      'answer': 'S',
      'options': ['F', 'S', 'T'],
    },
    {
      'sound': '/z/',
      'speak': 'zzz',
      'answer': 'Z',
      'options': ['S', 'Z', 'X'],
    },
    {
      'sound': '/h/',
      'speak': 'huh',
      'answer': 'H',
      'options': ['H', 'N', 'W'],
    },
    {
      'sound': '/j/',
      'speak': 'juh',
      'answer': 'J',
      'options': ['G', 'J', 'D'],
    },
    {
      'sound': '/l/',
      'speak': 'lll',
      'answer': 'L',
      'options': ['L', 'R', 'I'],
    },
    {
      'sound': '/r/',
      'speak': 'rrr',
      'answer': 'R',
      'options': ['R', 'L', 'W'],
    },
    {
      'sound': '/w/',
      'speak': 'wuh',
      'answer': 'W',
      'options': ['W', 'V', 'M'],
    },
    {
      'sound': '/y/',
      'speak': 'yuh',
      'answer': 'Y',
      'options': ['Y', 'J', 'I'],
    },
    {
      'sound': '/x/',
      'speak': 'ks',
      'answer': 'X',
      'options': ['X', 'Z', 'S'],
    },

    // -------------------------
    // SHORT VOWELS
    // -------------------------

    {
      'sound': '/a/',
      'speak': 'a as in apple',
      'answer': 'A',
      'options': ['A', 'E', 'O'],
    },
    {
      'sound': '/e/',
      'speak': 'e as in egg',
      'answer': 'E',
      'options': ['I', 'E', 'A'],
    },
    {
      'sound': '/i/',
      'speak': 'i as in igloo',
      'answer': 'I',
      'options': ['I', 'E', 'U'],
    },
    {
      'sound': '/o/',
      'speak': 'o as in octopus',
      'answer': 'O',
      'options': ['A', 'O', 'U'],
    },
    {
      'sound': '/u/',
      'speak': 'u as in umbrella',
      'answer': 'U',
      'options': ['U', 'O', 'A'],
    },

    // -------------------------
    // DIGRAPHS
    // -------------------------

    {
      'sound': '/sh/',
      'speak': 'sh',
      'answer': 'SH',
      'options': ['SH', 'CH', 'TH'],
    },
    {
      'sound': '/ch/',
      'speak': 'ch',
      'answer': 'CH',
      'options': ['CH', 'SH', 'TH'],
    },
    {
      'sound': '/th/',
      'speak': 'th',
      'answer': 'TH',
      'options': ['TH', 'SH', 'CH'],
    },
    {
      'sound': '/wh/',
      'speak': 'wh',
      'answer': 'WH',
      'options': ['W', 'WH', 'CH'],
    },
    {
      'sound': '/ph/',
      'speak': 'f',
      'answer': 'PH',
      'options': ['F', 'PH', 'P'],
    },
    {
      'sound': '/ng/',
      'speak': 'ng',
      'answer': 'NG',
      'options': ['N', 'NG', 'NK'],
    },
    {
      'sound': '/ck/',
      'speak': 'ck',
      'answer': 'CK',
      'options': ['K', 'CK', 'CH'],
    },

    // -------------------------
    // LONG VOWELS
    // -------------------------

    {
      'sound': '/ay/',
      'speak': 'ay',
      'answer': 'AY',
      'options': ['AI', 'AY', 'EA'],
    },
    {
      'sound': '/ee/',
      'speak': 'ee',
      'answer': 'EE',
      'options': ['EE', 'EA', 'IE'],
    },
    {
      'sound': '/oa/',
      'speak': 'oa',
      'answer': 'OA',
      'options': ['OA', 'OW', 'OO'],
    },
    {
      'sound': '/ai/',
      'speak': 'ay',
      'answer': 'AI',
      'options': ['AI', 'AY', 'EI'],
    },
    {
      'sound': '/ie/',
      'speak': 'eye',
      'answer': 'IE',
      'options': ['IE', 'EI', 'EE'],
    },

    // -------------------------
    // VOWEL TEAMS
    // -------------------------

    {
      'sound': '/oo/',
      'speak': 'oo',
      'answer': 'OO',
      'options': ['OO', 'OA', 'OU'],
    },
    {
      'sound': '/oi/',
      'speak': 'oy',
      'answer': 'OI',
      'options': ['OI', 'OY', 'OU'],
    },
    {
      'sound': '/oy/',
      'speak': 'oy',
      'answer': 'OY',
      'options': ['OI', 'OY', 'OA'],
    },
    {
      'sound': '/ou/',
      'speak': 'ow',
      'answer': 'OU',
      'options': ['OW', 'OU', 'OI'],
    },
    {
      'sound': '/ow/',
      'speak': 'ow',
      'answer': 'OW',
      'options': ['OW', 'OU', 'OA'],
    },
    {
      'sound': '/ea/',
      'speak': 'ee',
      'answer': 'EA',
      'options': ['EE', 'EA', 'IE'],
    },
    {
      'sound': '/ew/',
      'speak': 'oo',
      'answer': 'EW',
      'options': ['EW', 'EU', 'OO'],
    },

    // -------------------------
    // R-CONTROLLED VOWELS
    // -------------------------

    {
      'sound': '/ar/',
      'speak': 'ar',
      'answer': 'AR',
      'options': ['AR', 'ER', 'OR'],
    },
    {
      'sound': '/er/',
      'speak': 'er',
      'answer': 'ER',
      'options': ['ER', 'AR', 'IR'],
    },
    {
      'sound': '/ir/',
      'speak': 'er',
      'answer': 'IR',
      'options': ['IR', 'ER', 'OR'],
    },
    {
      'sound': '/or/',
      'speak': 'or',
      'answer': 'OR',
      'options': ['OR', 'AR', 'ER'],
    },
    {
      'sound': '/ur/',
      'speak': 'er',
      'answer': 'UR',
      'options': ['UR', 'IR', 'ER'],
    },
  ];

  // =====================================================
  // INITIALIZATION
  // =====================================================

  @override
  void initState() {
    super.initState();

    _createNewGame();
    _ttsService.initialize();
  }

  // =====================================================
  // CREATE RANDOM GAME
  // =====================================================

  void _createNewGame() {
    questions = List<Map<String, dynamic>>.from(allQuestions);

    // Randomize questions
    questions.shuffle(Random());

    // Select only the required number
    questions = questions.take(questionsPerGame).toList();

    // Randomize options
    for (final question in questions) {
      final options = List<String>.from(question['options']);

      options.shuffle(Random());

      question['options'] = options;
    }
  }

  // =====================================================
  // PLAY SOUND
  // =====================================================

  Future<void> _playSound() async {
    final question = questions[questionIndex];

    final textToSpeak = question['speak'] as String;

    await _ttsService.speak(textToSpeak);
  }

  // =====================================================
  // CHECK ANSWER
  // =====================================================

  void checkAnswer(String letter) {
    final correctAnswer = questions[questionIndex]['answer'];

    if (letter == correctAnswer) {
      setState(() {
        score += 10;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Great job! 🎉'),
          duration: Duration(milliseconds: 800),
        ),
      );

      Future.delayed(const Duration(milliseconds: 900), () {
        if (!mounted) return;

        if (questionIndex < questions.length - 1) {
          setState(() {
            questionIndex++;
          });
        } else {
          showFinalScore();
        }
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Try again!'),
          duration: Duration(milliseconds: 800),
        ),
      );
    }
  }

  // =====================================================
  // FINAL SCORE
  // =====================================================

  void showFinalScore() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: const Text('Game Complete! 🎉'),
          content: Text(
            'Your score is $score / ${questions.length * 10}',
          ),
          actions: [
            // PLAY AGAIN
            TextButton(
              onPressed: () {
                Navigator.pop(context);

                setState(() {
                  questionIndex = 0;
                  score = 0;

                  _createNewGame();
                });
              },
              child: const Text('Play Again'),
            ),

            // EXIT
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

  // =====================================================
  // DISPOSE
  // =====================================================

  @override
  void dispose() {
    _ttsService.dispose();
    super.dispose();
  }

  // =====================================================
  // UI
  // =====================================================

  @override
  Widget build(BuildContext context) {
    final question = questions[questionIndex];

    final options = question['options'] as List<String>;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Listen & Drag'),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [
            // =================================================
            // PROGRESS
            // =================================================

            LinearProgressIndicator(
              value: (questionIndex + 1) / questions.length,
              minHeight: 10,
            ),

            const SizedBox(height: 15),

            Text(
              'Question ${questionIndex + 1} of ${questions.length}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 35),

            // =================================================
            // LISTEN
            // =================================================

            const Text(
              'Listen to the sound',
              style: TextStyle(
                fontSize: 20,
              ),
            ),

            const SizedBox(height: 15),

            CircleAvatar(
              radius: 45,
              child: IconButton(
                icon: const Icon(
                  Icons.volume_up,
                  size: 45,
                ),
                onPressed: _playSound,
              ),
            ),

            // No phonics text is displayed here.

            const SizedBox(height: 50),

            // =================================================
            // DRAG INSTRUCTION
            // =================================================

            const Text(
              'Drag the correct letter here',
              style: TextStyle(
                fontSize: 18,
              ),
            ),

            const SizedBox(height: 20),

            // =================================================
            // DROP AREA
            // =================================================

            DragTarget<String>(
              onAcceptWithDetails: (details) {
                checkAnswer(details.data);
              },

              builder: (
                context,
                candidateData,
                rejectedData,
              ) {
                return Container(
                  width: 150,
                  height: 100,

                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 3,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),

                  child: const Center(
                    child: Icon(
                      Icons.download,
                      size: 40,
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 40),

            // =================================================
            // DRAGGABLE OPTIONS
            // =================================================

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,

              children: options.map((letter) {
                return Draggable<String>(
                  data: letter,

                  feedback: Material(
                    color: Colors.transparent,
                    child: LetterTile(
                      letter: letter,
                    ),
                  ),

                  childWhenDragging: Opacity(
                    opacity: 0.3,
                    child: LetterTile(
                      letter: letter,
                    ),
                  ),

                  child: LetterTile(
                    letter: letter,
                  ),
                );
              }).toList(),
            ),

            const Spacer(),

            // =================================================
            // SCORE
            // =================================================

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

// =====================================================
// LETTER TILE
// =====================================================

class LetterTile extends StatelessWidget {
  final String letter;

  const LetterTile({
    super.key,
    required this.letter,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 75,
      height: 75,
      alignment: Alignment.center,

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          width: 2,
        ),
      ),

      child: Text(
        letter,
        style: const TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}