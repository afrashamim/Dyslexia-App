import 'dart:math';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../tts/tts_service.dart';

class HearWordGame extends StatefulWidget {
  const HearWordGame({super.key});

  @override
  State<HearWordGame> createState() => _HearWordGameState();
}

class _HearWordGameState extends State<HearWordGame> {
  final Random random = Random();
  final TtsService _ttsService = TtsService();

  static const int questionsPerGame = 4;

  final Map<String, List<Map<String, dynamic>>> categories = {
    'Fruits': [
      {'word': 'apple', 'options': ['apple', 'upple', 'appli']},
      {'word': 'mango', 'options': ['mengo', 'mango', 'mangu']},
      {'word': 'banana', 'options': ['banena', 'banana', 'bananna']},
      {'word': 'orange', 'options': ['orenge', 'orange', 'oranj']},
      {'word': 'grape', 'options': ['graip', 'grape', 'grap']},
      {
        'word': 'watermelon',
        'options': ['watermellon', 'watermelon', 'wotermelon']
      },
      {
        'word': 'pineapple',
        'options': ['pineappel', 'pineapple', 'pineaple']
      },
      {
        'word': 'strawberry',
        'options': ['strawbery', 'strawberry', 'strawberri']
      },
      {'word': 'papaya', 'options': ['papeya', 'papaya', 'papayya']},
      {'word': 'guava', 'options': ['guava', 'gouva', 'gova']},
      {'word': 'lemon', 'options': ['lemon', 'lemmon', 'leman']},
      {'word': 'peach', 'options': ['peech', 'peach', 'pech']},
      {'word': 'pear', 'options': ['pair', 'pear', 'peer']},
      {'word': 'cherry', 'options': ['chery', 'cherry', 'cherri']},
      {'word': 'kiwi', 'options': ['kiwi', 'kewee', 'kiwie']},
      {'word': 'coconut', 'options': ['cocunut', 'coconut', 'coconat']},
      {'word': 'avocado', 'options': ['avacado', 'avocado', 'avacodo']},
      {'word': 'melon', 'options': ['mellon', 'melon', 'melan']},
      {'word': 'plum', 'options': ['plam', 'plum', 'ploom']},
      {'word': 'apricot', 'options': ['apricot', 'aprecot', 'aprikot']},
    ],

    'Animals': [
      {'word': 'cat', 'options': ['kat', 'cat', 'cet']},
      {'word': 'dog', 'options': ['dag', 'dog', 'dug']},
      {'word': 'fish', 'options': ['fesh', 'fish', 'fisch']},
      {'word': 'lion', 'options': ['lyon', 'lion', 'lien']},
      {'word': 'tiger', 'options': ['tiger', 'tigar', 'teger']},
      {'word': 'rabbit', 'options': ['rabit', 'rabbit', 'rabbet']},
      {'word': 'monkey', 'options': ['monky', 'monkey', 'munkey']},
      {
        'word': 'elephant',
        'options': ['elefant', 'elephant', 'eliphant']
      },
      {'word': 'horse', 'options': ['hourse', 'horse', 'horce']},
      {'word': 'cow', 'options': ['cow', 'caw', 'kow']},
      {'word': 'goat', 'options': ['got', 'goat', 'gote']},
      {'word': 'sheep', 'options': ['shep', 'sheep', 'ship']},
      {'word': 'zebra', 'options': ['zeebra', 'zebra', 'zibra']},
      {'word': 'giraffe', 'options': ['girafe', 'giraffe', 'giraff']},
      {'word': 'bear', 'options': ['beer', 'bear', 'ber']},
      {'word': 'turtle', 'options': ['turtel', 'turtle', 'turtal']},
      {'word': 'dolphin', 'options': ['dolfin', 'dolphin', 'dolfhin']},
      {'word': 'parrot', 'options': ['parot', 'parrot', 'parrut']},
      {'word': 'penguin', 'options': ['pengwin', 'penguin', 'penguen']},
    ],

    'Flowers': [
      {'word': 'rose', 'options': ['roze', 'rose', 'roas']},
      {'word': 'lily', 'options': ['lilly', 'lily', 'lili']},
      {'word': 'lotus', 'options': ['lotus', 'lotes', 'latus']},
      {'word': 'tulip', 'options': ['tulep', 'tulip', 'tulup']},
      {'word': 'daisy', 'options': ['daisy', 'daysy', 'daizy']},
      {
        'word': 'sunflower',
        'options': ['sunflour', 'sunflower', 'sunflowar']
      },
      {'word': 'jasmine', 'options': ['jasmin', 'jasmine', 'jasmeen']},
      {
        'word': 'hibiscus',
        'options': ['hibiscus', 'hibiskus', 'hibiscas']
      },
      {
        'word': 'marigold',
        'options': ['marigould', 'marigold', 'marigald']
      },
      {
        'word': 'lavender',
        'options': ['lavandar', 'lavender', 'lavendar']
      },
      {'word': 'orchid', 'options': ['orkid', 'orchid', 'orkhid']},
      {'word': 'dahlia', 'options': ['dalia', 'dahlia', 'dahliah']},
      {
        'word': 'daffodil',
        'options': ['daffodill', 'daffodil', 'daffodel']
      },
      {'word': 'violet', 'options': ['violet', 'vilolet', 'vialet']},
      {'word': 'poppy', 'options': ['poppi', 'poppy', 'popy']},
      {'word': 'petunia', 'options': ['petunya', 'petunia', 'petuniaa']},
      {
        'word': 'magnolia',
        'options': ['magnolia', 'magnolya', 'magnolea']
      },
      {
        'word': 'chrysanthemum',
        'options': ['chrisanthemum', 'chrysanthemum', 'crysanthemum']
      },
      {'word': 'gerbera', 'options': ['gerbera', 'gerbira', 'gerbora']},
    ],

    'Food': [
      {'word': 'pizza', 'options': ['piza', 'pizza', 'pissa']},
      {'word': 'bread', 'options': ['bred', 'bread', 'brad']},
      {'word': 'rice', 'options': ['rise', 'rice', 'rees']},
      {'word': 'cake', 'options': ['cak', 'cake', 'keik']},
      {'word': 'burger', 'options': ['burgar', 'burger', 'burjer']},
      {'word': 'noodles', 'options': ['nudles', 'noodles', 'noddles']},
      {'word': 'cookie', 'options': ['cooky', 'cookie', 'cooki']},
      {
        'word': 'sandwich',
        'options': ['sandwitch', 'sandwich', 'sandwiche']
      },
      {'word': 'pasta', 'options': ['pasta', 'pesta', 'pastaa']},
      {'word': 'cheese', 'options': ['chease', 'cheese', 'chees']},
      {'word': 'soup', 'options': ['soop', 'soup', 'supe']},
      {'word': 'salad', 'options': ['salad', 'selad', 'sallad']},
      {
        'word': 'chocolate',
        'options': ['chocklate', 'chocolate', 'chocolat']
      },
      {'word': 'pancake', 'options': ['pencake', 'pancake', 'pancak']},
      {'word': 'noodle', 'options': ['nodel', 'noodle', 'noudle']},
      {'word': 'biscuit', 'options': ['biskit', 'biscuit', 'biscut']},
      {'word': 'popcorn', 'options': ['popkorn', 'popcorn', 'popkorn']},
      {'word': 'icecream', 'options': ['icecreem', 'icecream', 'icecrem']},
      {'word': 'omelette', 'options': ['omelet', 'omelette', 'omlette']},
    ],
  };

  List<Map<String, dynamic>> questions = [];

  late Map<String, dynamic> currentQuestion;

  List<String> options = [];

  int questionIndex = 0;
  int score = 0;

  bool answered = false;
  bool correct = false;
  bool gameFinished = false;

  @override
  void initState() {
    super.initState();

    _ttsService.initialize();
    startGame();
  }

  List<Map<String, dynamic>> getAllWords() {
    final List<Map<String, dynamic>> allWords = [];

    for (final categoryWords in categories.values) {
      for (final word in categoryWords) {
        allWords.add(Map<String, dynamic>.from(word));
      }
    }

    return allWords;
  }

  void startGame() {
    final allWords = getAllWords();

    allWords.shuffle(random);

    questions = allWords.take(questionsPerGame).toList();

    questionIndex = 0;
    score = 0;
    answered = false;
    correct = false;
    gameFinished = false;

    loadQuestion();
  }

  void loadQuestion() {
    currentQuestion = questions[questionIndex];

    options = List<String>.from(
      currentQuestion['options'],
    );

    options.shuffle(random);

    answered = false;
    correct = false;
  }

  Future<void> playSound() async {
    final word = currentQuestion['word'] as String;

    await _ttsService.stop();
    await _ttsService.speak(word);
  }

  void checkAnswer(String selectedWord) {
    if (answered || gameFinished) {
      return;
    }

    final correctWord = currentQuestion['word'] as String;

    if (selectedWord == correctWord) {
      setState(() {
        answered = true;
        correct = true;
        score += 10;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Great job! 🎉'),
          duration: Duration(milliseconds: 700),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Try again! Listen carefully.'),
          duration: Duration(milliseconds: 700),
        ),
      );
    }
  }

  void nextQuestion() {
    _ttsService.stop();

    if (questionIndex < questions.length - 1) {
      setState(() {
        questionIndex++;
        loadQuestion();
      });
    } else {
      setState(() {
        gameFinished = true;
      });
    }
  }

  void playAgain() {
    _ttsService.stop();

    setState(() {
      startGame();
    });
  }

  @override
  void dispose() {
    _ttsService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hear & Choose'),
        centerTitle: true,
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
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 15),

          LinearProgressIndicator(
            value: (questionIndex + 1) / questionsPerGame,
            minHeight: 8,
            borderRadius: BorderRadius.circular(10),
          ),

          const SizedBox(height: 10),

          Text(
            'Question ${questionIndex + 1} of $questionsPerGame',
            style: TextStyle(
              fontFamily: kAppFont,
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: AppColors.ink,
            ),
          ),

          const SizedBox(height: 28),

          Text(
            'Listen to the word',
            style: TextStyle(
              fontFamily: kAppFont,
              fontSize: 23,
              fontWeight: FontWeight.bold,
              color: AppColors.ink,
            ),
          ),

          const SizedBox(height: 6),

          Text(
            'Tap the speaker and listen carefully.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: kAppFont,
              fontSize: 15,
              color: AppColors.ink,
            ),
          ),

          const SizedBox(height: 16),

          Container(
            width: 78,
            height: 78,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(width: 2),
            ),
            child: IconButton(
              onPressed: playSound,
              icon: const Icon(
                Icons.volume_up_rounded,
                size: 42,
              ),
            ),
          ),

          const SizedBox(height: 22),

          Text(
            'Drag the correct word here',
            style: TextStyle(
              fontFamily: kAppFont,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.ink,
            ),
          ),

          const SizedBox(height: 12),

          DragTarget<String>(
            onAcceptWithDetails: (details) {
              checkAnswer(details.data);
            },
            builder: (
              context,
              candidateData,
              rejectedData,
            ) {
              return AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: double.infinity,
                height: 75,
                decoration: BoxDecoration(
                  color: correct
                      ? Colors.green.withValues(alpha: 0.15)
                      : AppColors.readingPaper,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(width: 2),
                ),
                child: Center(
                  child: correct
                      ? const Icon(
                          Icons.check_circle,
                          size: 40,
                        )
                      : const Icon(
                          Icons.download_rounded,
                          size: 34,
                        ),
                ),
              );
            },
          ),

          const SizedBox(height: 24),

          Row(
            children: options.map((word) {
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Draggable<String>(
                    data: word,
                    feedback: Material(
                      color: Colors.transparent,
                      child: WordTile(word: word),
                    ),
                    childWhenDragging: Opacity(
                      opacity: 0.3,
                      child: WordTile(word: word),
                    ),
                    child: WordTile(word: word),
                  ),
                ),
              );
            }).toList(),
          ),

          if (correct)
            Padding(
              padding: const EdgeInsets.only(
                top: 14,
                bottom: 8,
              ),
              child: SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: nextQuestion,
                  child: Text(
                    questionIndex == questions.length - 1
                        ? 'Finish'
                        : 'Next Word',
                    style: TextStyle(
                      fontFamily: kAppFont,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),

          const SizedBox(height: 10),

          Text(
            'Score: $score / ${questionsPerGame * 10}',
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

  Widget buildCompletedScreen() {
    return Column(
      children: [
        const Spacer(),

        const Icon(
          Icons.celebration_outlined,
          size: 70,
        ),

        const SizedBox(height: 20),

        Text(
          'Great job! 🎉',
          style: TextStyle(
            fontFamily: kAppFont,
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: AppColors.ink,
          ),
        ),

        const SizedBox(height: 12),

        Text(
          'You completed all 4 questions!',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: kAppFont,
            fontSize: 18,
            color: AppColors.ink,
          ),
        ),

        const SizedBox(height: 20),

        Text(
          'Final Score: $score / ${questionsPerGame * 10}',
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
          height: 54,
          child: ElevatedButton(
            onPressed: playAgain,
            child: Text(
              'Play Again',
              style: TextStyle(
                fontFamily: kAppFont,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),

        const Spacer(),
      ],
    );
  }
}

class WordTile extends StatelessWidget {
  final String word;

  const WordTile({
    super.key,
    required this.word,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.readingPaper,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(width: 2),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 3),
        child: Text(
          word,
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontFamily: kAppFont,
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: AppColors.ink,
          ),
        ),
      ),
    );
  }
}