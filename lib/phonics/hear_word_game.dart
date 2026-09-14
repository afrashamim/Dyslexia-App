import 'dart:math';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class HearWordGame extends StatefulWidget {
  const HearWordGame({super.key});

  @override
  State<HearWordGame> createState() => _HearWordGameState();
}

class _HearWordGameState extends State<HearWordGame> {
  final Random random = Random();

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
      {'word': 'zebra', 'options': ['zeebra', 'zebra', 'zibra']},
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
      {'word': 'dahlia', 'options': ['dalia', 'dahlia', 'dahliah']},
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
      {'word': 'sandwich', 'options': ['sandwitch', 'sandwich', 'sandwiche']},
    ],
  };

  String selectedCategory = 'Fruits';

  List<Map<String, dynamic>> remainingWords = [];
  List<Map<String, dynamic>> currentRound = [];

  late Map<String, dynamic> currentQuestion;

  List<String> options = [];

  int questionIndex = 0;
  int score = 0;

  bool answered = false;
  bool correct = false;

  @override
  void initState() {
    super.initState();
    prepareCategory();
  }

  // Remove duplicate words from a category.
  List<Map<String, dynamic>> getUniqueWords(
    List<Map<String, dynamic>> words,
  ) {
    final Set<String> seen = {};

    return words.where((item) {
      final word = item['word'] as String;

      if (seen.contains(word)) {
        return false;
      }

      seen.add(word);
      return true;
    }).map((item) {
      return Map<String, dynamic>.from(item);
    }).toList();
  }

  void prepareCategory() {
    remainingWords = getUniqueWords(categories[selectedCategory]!);
    remainingWords.shuffle(random);
    startNextRound();
  }

  void startNextRound() {
    if (remainingWords.isEmpty) {
      setState(() {
        currentRound = [];
      });
      return;
    }

    final numberOfWords =
        remainingWords.length >= 4 ? 4 : remainingWords.length;

    currentRound = remainingWords.take(numberOfWords).toList();

    remainingWords.removeRange(0, numberOfWords);

    questionIndex = 0;
    loadQuestion();
  }

  void loadQuestion() {
    currentQuestion = currentRound[questionIndex];

    options = List<String>.from(currentQuestion['options']);
    options.shuffle(random);

    answered = false;
    correct = false;
  }

  void checkAnswer(String selectedWord) {
    if (answered) return;

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
    if (questionIndex < currentRound.length - 1) {
      setState(() {
        questionIndex++;
        loadQuestion();
      });
    } else {
      if (remainingWords.isNotEmpty) {
        setState(() {
          startNextRound();
        });
      } else {
        setState(() {
          currentRound = [];
        });
      }
    }
  }

  void changeCategory(String? category) {
    if (category == null) return;

    setState(() {
      selectedCategory = category;
      score = 0;

      remainingWords = getUniqueWords(categories[selectedCategory]!);
      remainingWords.shuffle(random);

      startNextRound();
    });
  }

  void playSound() {
    // Connect teammate TTS here.
  }

  @override
  Widget build(BuildContext context) {
    final bool categoryFinished =
        remainingWords.isEmpty && currentRound.isEmpty;

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
          child: categoryFinished
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
          Align(
            alignment: Alignment.centerLeft,
            child: DropdownButton<String>(
              value: selectedCategory,
              underline: const SizedBox(),
              items: categories.keys.map((category) {
                return DropdownMenuItem<String>(
                  value: category,
                  child: Text(
                    category,
                    style: TextStyle(
                      fontFamily: kAppFont,
                      fontSize: 17,
                      color: AppColors.ink,
                    ),
                  ),
                );
              }).toList(),
              onChanged: changeCategory,
            ),
          ),

          const SizedBox(height: 5),

          LinearProgressIndicator(
            value: (questionIndex + 1) / currentRound.length,
            minHeight: 8,
            borderRadius: BorderRadius.circular(10),
          ),

          const SizedBox(height: 10),

          Text(
            'Word ${questionIndex + 1} of ${currentRound.length}',
            style: TextStyle(
              fontFamily: kAppFont,
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: AppColors.ink,
            ),
          ),

          const SizedBox(height: 22),

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

          const SizedBox(height: 14),

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

          const SizedBox(height: 18),

          Text(
            'Drag the correct word here',
            style: TextStyle(
              fontFamily: kAppFont,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.ink,
            ),
          ),

          const SizedBox(height: 10),

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

          const SizedBox(height: 22),

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
                top: 12,
                bottom: 8,
              ),
              child: SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: const Size(
                      double.infinity,
                      56,
                    ),
                    tapTargetSize:
                        MaterialTapTargetSize.shrinkWrap,
                  ),
                  onPressed: nextQuestion,
                  child: Text(
                    questionIndex == currentRound.length - 1
                        ? (remainingWords.isEmpty
                            ? 'Finish'
                            : 'Next Try')
                        : 'Next Word',
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
            ),

          const SizedBox(height: 8),

          Text(
            'Score: $score',
            style: TextStyle(
              fontFamily: kAppFont,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.ink,
            ),
          ),

          const SizedBox(height: 15),
        ],
      ),
    );
  }

  Widget buildCompletedScreen() {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: DropdownButton<String>(
            value: selectedCategory,
            underline: const SizedBox(),
            items: categories.keys.map((category) {
              return DropdownMenuItem<String>(
                value: category,
                child: Text(
                  category,
                  style: TextStyle(
                    fontFamily: kAppFont,
                    fontSize: 17,
                    color: AppColors.ink,
                  ),
                ),
              );
            }).toList(),
            onChanged: changeCategory,
          ),
        ),

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
          'You completed all the words in $selectedCategory.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: kAppFont,
            fontSize: 18,
            color: AppColors.ink,
          ),
        ),

        const SizedBox(height: 20),

        Text(
          'Final Score: $score',
          style: TextStyle(
            fontFamily: kAppFont,
            fontSize: 21,
            fontWeight: FontWeight.bold,
            color: AppColors.ink,
          ),
        ),

        const SizedBox(height: 30),

        Text(
          'Choose another category to continue.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: kAppFont,
            fontSize: 17,
            color: AppColors.ink,
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