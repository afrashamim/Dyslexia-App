import 'package:flutter/material.dart';

class ListenDragGame extends StatefulWidget {
  const ListenDragGame({super.key});

  @override
  State<ListenDragGame> createState() => _ListenDragGameState();
}

class _ListenDragGameState extends State<ListenDragGame> {
  int questionIndex = 0;
  int score = 0;

  final questions = [
    {
      'sound': '/b/',
      'answer': 'B',
      'options': ['B', 'D', 'P'],
    },
    {
      'sound': '/k/',
      'answer': 'C',
      'options': ['G', 'C', 'T'],
    },
    {
      'sound': '/m/',
      'answer': 'M',
      'options': ['N', 'M', 'W'],
    },
    {
      'sound': '/s/',
      'answer': 'S',
      'options': ['F', 'S', 'T'],
    },
  ];

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
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                setState(() {
                  questionIndex = 0;
                  score = 0;
                });
              },
              child: const Text('Play Again'),
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
            // Progress
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

            // Sound button
            const Text(
              'Listen to the sound',
              style: TextStyle(fontSize: 20),
            ),

            const SizedBox(height: 15),

            CircleAvatar(
              radius: 45,
              child: IconButton(
                icon: const Icon(
                  Icons.volume_up,
                  size: 45,
                ),
                onPressed: () {
                  // TTS will be connected by your teammate later.
                },
              ),
            ),

            const SizedBox(height: 15),

            Text(
              question['sound'] as String,
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 50),

            const Text(
              'Drag the correct letter here',
              style: TextStyle(fontSize: 18),
            ),

            const SizedBox(height: 20),

            // Drop area
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

            // Draggable letters
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: options.map((letter) {
                return Draggable<String>(
                  data: letter,
                  feedback: Material(
                    color: Colors.transparent,
                    child: LetterTile(letter: letter),
                  ),
                  childWhenDragging: Opacity(
                    opacity: 0.3,
                    child: LetterTile(letter: letter),
                  ),
                  child: LetterTile(letter: letter),
                );
              }).toList(),
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
        border: Border.all(width: 2),
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