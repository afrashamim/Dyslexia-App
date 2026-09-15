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
          'speak': 'muh', // was 'm' -> TTS said the letter name "em"
          'answer': 'M',
          'options': ['N', 'M', 'W'],
        },
        {
          'sound': '/n/',
          'speak': 'nuh', // was 'n' -> TTS said the letter name "en"
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
          'options': ['G', 'C', 'T'], // was ['G','C','K'] -> K makes the identical /k/ sound as C
        },
        {
          'sound': '/g/',
          'speak': 'guh',
          'answer': 'G',
          'options': ['G', 'C', 'D'],
        },
        {
          'sound': '/f/',
          'speak': 'fah', // was 'f' -> TTS said the letter name "eff"
          'answer': 'F',
          'options': ['F', 'V', 'S'],
        },
        {
          'sound': '/v/',
          'speak': 'vuh', // was 'vvv' -> inconsistent across engines
          'answer': 'V',
          'options': ['F', 'V', 'W'],
        },
        {
          'sound': '/s/',
          'speak': 'suh', // was 'sss' -> inconsistent across engines
          'answer': 'S',
          'options': ['F', 'S', 'T'],
        },
        {
          'sound': '/z/',
          'speak': 'zuh', // was 'zzz' -> inconsistent across engines
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
          'options': ['W', 'J', 'D'], // was ['G','J','D'] -> soft G makes the identical /j/ sound
        },
        {
          'sound': '/l/',
          'speak': 'luh', // was 'lll' -> inconsistent across engines
          'answer': 'L',
          'options': ['L', 'R', 'I'],
        },
        {
          'sound': '/r/',
          'speak': 'ruh', // was 'rrr' -> inconsistent across engines
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
          'speak': 'eks', // was 'ks' -> TTS spelled it out as "K" "S"
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
          'speak': 'shh', // was 'sh' -> more reliably read as the hushing sound
          'answer': 'SH',
          'options': ['SH', 'CH', 'TH'],
        },
        {
          'sound': '/ch/',
          'speak': 'chuh', // was 'ch'
          'answer': 'CH',
          'options': ['CH', 'SH', 'TH'],
        },
        {
          'sound': '/th/',
          'speak': 'thuh', // was 'th'
          'answer': 'TH',
          'options': ['TH', 'SH', 'CH'],
        },
        {
          'sound': '/wh/',
          'speak': 'wuh', // was 'wh' -> /wh/ is pronounced like /w/
          'answer': 'WH',
          'options': ['SH', 'WH', 'CH'], // was ['W','WH','CH'] -> /wh/ sounds identical to /w/
        },
        {
          'sound': '/ph/',
          'speak': 'fuh', // was 'f' -> kept as the /f/ sound, consistent style
          'answer': 'PH',
          'options': ['V', 'PH', 'P'], // was ['F','PH','P'] -> F makes the identical /f/ sound as PH
        },
        {
          'sound': '/ng/',
          'speak': 'ing', // was 'ng' -> risk of being spelled out; "ing" carries the sound
          'answer': 'NG',
          'options': ['N', 'NG', 'NK'],
        },
        {
          'sound': '/ck/',
          'speak': 'kuh', // was 'ck' -> /ck/ makes the /k/ sound
          'answer': 'CK',
          'options': ['T', 'CK', 'CH'], // was ['K','CK','CH'] -> K makes the identical /k/ sound as CK
        },

        // -------------------------
        // LONG VOWELS
        // -------------------------

        {
          'sound': '/ay/',
          'speak': 'ay',
          'answer': 'AY',
          'options': ['OO', 'AY', 'EA'], // was ['AI','AY','EA'] -> AI makes the identical /ay/ sound
        },
        {
          'sound': '/ee/',
          'speak': 'ee',
          'answer': 'EE',
          'options': ['EE', 'OO', 'IE'], // was ['EE','EA','IE'] -> EA can make this identical /ee/ sound
        },
        {
          'sound': '/oa/',
          'speak': 'oh', // was 'oa' -> not a standard spelling on its own; "oh" is unambiguous
          'answer': 'OA',
          'options': ['OA', 'EE', 'OO'], // was ['OA','OW','OO'] -> OW can also make this long-O sound (e.g. "snow")
        },
        {
          'sound': '/ai/',
          'speak': 'ay',
          'answer': 'AI',
          'options': ['OA', 'AI', 'EA'], // was ['AI','AY','EI'] -> AY (and often EI) make the identical /ay/ sound
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
          'options': ['OI', 'OO', 'OU'], // was ['OI','OY','OU'] -> OY makes the identical /oy/ sound
        },
        {
          'sound': '/oy/',
          'speak': 'oy',
          'answer': 'OY',
          'options': ['OO', 'OY', 'OA'], // was ['OI','OY','OA'] -> OI makes the identical /oy/ sound
        },
        {
          'sound': '/ou/',
          'speak': 'ow',
          'answer': 'OU',
          'options': ['OO', 'OU', 'OI'], // was ['OW','OU','OI'] -> OW makes the identical /ow/ sound
        },
        {
          'sound': '/ow/',
          'speak': 'ow',
          'answer': 'OW',
          'options': ['OW', 'EE', 'OA'], // was ['OW','OU','OA'] -> OU makes the identical /ow/ sound
        },
        {
          'sound': '/ea/',
          'speak': 'e',
          'answer': 'EA',
          'options': ['OO', 'EA', 'IE'], // was ['EE','EA','IE'] -> EE makes the identical /ee/ sound
        },
        {
          'sound': '/ew/',
          'speak': 'oo',
          'answer': 'EW',
          'options': ['EW', 'EU', 'OW'], // was ['EW','EU','OO'] -> OO makes the identical /oo/ sound
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
          'options': ['ER', 'AR', 'OR'], // was ['ER','AR','IR'] -> IR makes the identical /er/ sound
        },
        {
          'sound': '/ir/',
          'speak': 'er',
          'answer': 'IR',
          'options': ['IR', 'AR', 'OR'], // was ['IR','ER','OR'] -> ER makes the identical /er/ sound
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
          'options': ['UR', 'AR', 'OR'], // was ['UR','IR','ER'] -> both IR and ER make the identical /er/ sound
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