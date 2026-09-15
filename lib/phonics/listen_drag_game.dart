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

  // Used to show the completed screen
  bool gameFinished = false;

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
      'speak': 'muh',
      'answer': 'M',
      'options': ['N', 'M', 'W'],
    },
    {
      'sound': '/n/',
      'speak': 'nuh',
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
      'options': ['G', 'C', 'T'],
    },
    {
      'sound': '/g/',
      'speak': 'guh',
      'answer': 'G',
      'options': ['G', 'C', 'D'],
    },
    {
      'sound': '/f/',
      'speak': 'fah',
      'answer': 'F',
      'options': ['F', 'V', 'S'],
    },
    {
      'sound': '/v/',
      'speak': 'vuh',
      'answer': 'V',
      'options': ['F', 'V', 'W'],
    },
    {
      'sound': '/s/',
      'speak': 'suh',
      'answer': 'S',
      'options': ['F', 'S', 'T'],
    },
    {
      'sound': '/z/',
      'speak': 'zuh',
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
      'options': ['W', 'J', 'D'],
    },
    {
      'sound': '/l/',
      'speak': 'luh',
      'answer': 'L',
      'options': ['L', 'R', 'I'],
    },
    {
      'sound': '/r/',
      'speak': 'ruh',
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
      'speak': 'eks',
      'answer': 'X',
      'options': ['X', 'Z', 'S'],
    },

    // -------------------------
    // SHORT VOWELS
    // -------------------------

    {
      'sound': '/a/',
      'speak': 'aa',
      'answer': 'A',
      'options': ['A', 'E', 'O'],
    },
    {
      'sound': '/e/',
      'speak': 'e',
      'answer': 'E',
      'options': ['I', 'E', 'A'],
    },
    {
      'sound': '/i/',
      'speak': 'i',
      'answer': 'I',
      'options': ['I', 'E', 'U'],
    },
    {
      'sound': '/o/',
      'speak': 'o',
      'answer': 'O',
      'options': ['A', 'O', 'U'],
    },
    {
      'sound': '/u/',
      'speak': 'u',
      'answer': 'U',
      'options': ['U', 'O', 'A'],
    },

    // -------------------------
    // DIGRAPHS
    // -------------------------

    {
      'sound': '/sh/',
      'speak': 'shh',
      'answer': 'SH',
      'options': ['SH', 'CH', 'TH'],
    },
    {
      'sound': '/ch/',
      'speak': 'chuh',
      'answer': 'CH',
      'options': ['CH', 'SH', 'TH'],
    },
    {
      'sound': '/th/',
      'speak': 'thuh',
      'answer': 'TH',
      'options': ['TH', 'SH', 'CH'],
    },
    {
      'sound': '/wh/',
      'speak': 'wuh',
      'answer': 'WH',
      'options': ['SH', 'WH', 'CH'],
    },
    {
      'sound': '/ph/',
      'speak': 'fuh',
      'answer': 'PH',
      'options': ['V', 'PH', 'P'],
    },
    {
      'sound': '/ng/',
      'speak': 'ing',
      'answer': 'NG',
      'options': ['N', 'NG', 'NK'],
    },
    {
      'sound': '/ck/',
      'speak': 'kuh',
      'answer': 'CK',
      'options': ['T', 'CK', 'CH'],
    },

    // -------------------------
    // LONG VOWELS
    // -------------------------

    {
      'sound': '/ay/',
      'speak': 'ay',
      'answer': 'AY',
      'options': ['OO', 'AY', 'EA'],
    },
    {
      'sound': '/ee/',
      'speak': 'ee',
      'answer': 'EE',
      'options': ['EE', 'OO', 'IE'],
    },
    {
      'sound': '/oa/',
      'speak': 'oh',
      'answer': 'OA',
      'options': ['OA', 'EE', 'OO'],
    },
    {
      'sound': '/ai/',
      'speak': 'ay',
      'answer': 'AI',
      'options': ['OA', 'AI', 'EA'],
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
      'options': ['OI', 'OO', 'OU'],
    },
    {
      'sound': '/oy/',
      'speak': 'oy',
      'answer': 'OY',
      'options': ['OO', 'OY', 'OA'],
    },
    {
      'sound': '/ou/',
      'speak': 'ow',
      'answer': 'OU',
      'options': ['OO', 'OU', 'OI'],
    },
    {
      'sound': '/ow/',
      'speak': 'ow',
      'answer': 'OW',
      'options': ['OW', 'EE', 'OA'],
    },
    {
      'sound': '/ea/',
      'speak': 'e',
      'answer': 'EA',
      'options': ['OO', 'EA', 'IE'],
    },
    {
      'sound': '/ew/',
      'speak': 'oo',
      'answer': 'EW',
      'options': ['EW', 'EU', 'OW'],
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
      'options': ['ER', 'AR', 'OR'],
    },
    {
      'sound': '/ir/',
      'speak': 'er',
      'answer': 'IR',
      'options': ['IR', 'AR', 'OR'],
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
      'options': ['UR', 'AR', 'OR'],
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

    questions.shuffle(Random());

    questions = questions.take(questionsPerGame).toList();

    for (final question in questions) {
      final options = List<String>.from(question['options']);

      options.shuffle(Random());

      question['options'] = options;
    }

    questionIndex = 0;
    score = 0;
    gameFinished = false;
  }

  // =====================================================
  // PLAY SOUND
  // =====================================================

  Future<void> _playSound() async {
    final question = questions[questionIndex];

    final textToSpeak = question['speak'] as String;

    await _ttsService.stop();
    await _ttsService.speak(textToSpeak);
  }

  // =====================================================
  // CHECK ANSWER
  // =====================================================

  void checkAnswer(String letter) {
    if (gameFinished) {
      return;
    }

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
          setState(() {
            gameFinished = true;
          });
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
  // PLAY AGAIN
  // =====================================================

  void playAgain() {
    _ttsService.stop();

    setState(() {
      _createNewGame();
    });
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
  // MAIN BUILD
  // =====================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Listen & Drag'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: gameFinished
              ? buildCompletedScreen()
              : buildGameScreen(),
        ),
      ),
    );
  }

  // =====================================================
  // GAME SCREEN
  // =====================================================

  Widget buildGameScreen() {
    final question = questions[questionIndex];

    final options = question['options'] as List<String>;

    return Column(
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
    );
  }

  // =====================================================
  // COMPLETED SCREEN
  // =====================================================

  Widget buildCompletedScreen() {
    return Column(
      children: [
        const Spacer(),

        const Icon(
          Icons.celebration_outlined,
          size: 70,
        ),

        const SizedBox(height: 20),

        const Text(
          'Great job! 🎉',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 12),

        const Text(
          'You completed all 4 questions!',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18,
          ),
        ),

        const SizedBox(height: 20),

        Text(
          'Final Score: $score / ${questionsPerGame * 10}',
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 21,
            fontWeight: FontWeight.bold,
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
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: const Text(
              'Play Again',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                height: 1.2,
              ),
            ),
          ),
        ),

        const Spacer(),
      ],
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
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}