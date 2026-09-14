import 'package:flutter/material.dart';
import 'tts_service.dart';

class TtsTestScreen extends StatefulWidget {
  const TtsTestScreen({super.key});

  @override
  State<TtsTestScreen> createState() => _TtsTestScreenState();
}

class _TtsTestScreenState extends State<TtsTestScreen> {
  int _highlightStart = -1;
  int _highlightEnd = -1;
  int _resumeBaseOffset = 0; // tracks how far we'd gotten before the last pause
  final TtsService _ttsService = TtsService();
  final TextEditingController _textController = TextEditingController();

  double _speechRate = 0.5;
  double _pitch = 1.0;
  double _volume = 1.0;

  bool _isPlaying = false;
  bool _isPaused = false;

  @override
  void initState() {
    super.initState();
    _initializeTts();
  }

  Future<void> _initializeTts() async {
    await _ttsService.initialize();

    _ttsService.setProgressHandler(
      (text, startOffset, endOffset, word) {
        if (!mounted) return;

        setState(() {
          _highlightStart = _resumeBaseOffset + startOffset;
          _highlightEnd = _resumeBaseOffset + endOffset;
        });
      },
    );

    _ttsService.setStartHandler(() {
      if (!mounted) return;

      setState(() {
        _isPlaying = true;
        _isPaused = false;
      });
    });

    _ttsService.setCompletionHandler(() {
      if (!mounted) return;

      setState(() {
        _isPlaying = false;
        _isPaused = false;
        _highlightStart = -1;
        _highlightEnd = -1;
        _resumeBaseOffset = 0;
      });
    });

    _ttsService.setPauseHandler(() {
      if (!mounted) return;

      setState(() {
        _isPlaying = false;
        _isPaused = true;
      });
    });

    _ttsService.setContinueHandler(() {
      if (!mounted) return;

      setState(() {
        _isPlaying = true;
        _isPaused = false;
      });
    });

    _ttsService.setCancelHandler(() {
      if (!mounted) return;

      setState(() {
        _isPlaying = false;
        _isPaused = false;
        _highlightStart = -1;
        _highlightEnd = -1;
        _resumeBaseOffset = 0;
      });
    });

    _ttsService.setErrorHandler((message) {
      if (!mounted) return;

      setState(() {
        _isPlaying = false;
        _isPaused = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('TTS error: $message'),
        ),
      );
    });
  }

  // Decides whether Play should start fresh or resume from a pause.
  Future<void> _playOrResume() async {
    if (_isPaused) {
      await _resume();
    } else {
      await _speak();
    }
  }

  Future<void> _speak() async {
    final text = _textController.text.trim();

    if (text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter some text first.'),
        ),
      );
      return;
    }

    _resumeBaseOffset = 0; // fresh start, not a resume
    await _ttsService.speak(text);
  }

  Future<void> _resume() async {
    final fullText = _textController.text;
    final start = _resumeBaseOffset.clamp(0, fullText.length);
    final remaining = fullText.substring(start);

    if (remaining.trim().isEmpty) {
      return;
    }

    // Deliberately do NOT reset _resumeBaseOffset here —
    // it's what lets the highlight continue from the right place.
    await _ttsService.speak(remaining);
  }

  Future<void> _pause() async {
    if (_highlightStart >= 0) {
      _resumeBaseOffset = _highlightStart;
    }
    await _ttsService.pause();
  }

  Future<void> _stop() async {
    await _ttsService.stop();

    if (!mounted) return;

    setState(() {
      _isPlaying = false;
      _isPaused = false;
      _highlightStart = -1;
      _highlightEnd = -1;
      _resumeBaseOffset = 0;
    });
  }

  Future<void> _setSpeechRate(double value) async {
    setState(() {
      _speechRate = value;
    });

    await _ttsService.setSpeechRate(value);
  }

  Future<void> _setPitch(double value) async {
    setState(() {
      _pitch = value;
    });

    await _ttsService.setPitch(value);
  }

  Future<void> _setVolume(double value) async {
    setState(() {
      _volume = value;
    });

    await _ttsService.setVolume(value);
  }

  Widget _buildHighlightedText() {
    final text = _textController.text;

    if (text.isEmpty) {
      return const SizedBox();
    }

    if (_highlightStart < 0 || _highlightEnd <= _highlightStart) {
      return Text(
        text,
        style: const TextStyle(
          fontSize: 20,
          color: Colors.black,
        ),
      );
    }

    // Guard against offsets that overshoot the text length
    final safeStart = _highlightStart.clamp(0, text.length);
    final safeEnd = _highlightEnd.clamp(0, text.length);

    final before = text.substring(0, safeStart);
    final highlighted = text.substring(safeStart, safeEnd);
    final after = text.substring(safeEnd);

    return RichText(
      text: TextSpan(
        style: const TextStyle(
          fontSize: 20,
          color: Colors.black,
        ),
        children: [
          TextSpan(text: before),
          TextSpan(
            text: highlighted,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              backgroundColor: Colors.yellow,
            ),
          ),
          TextSpan(text: after),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    _ttsService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Read Aloud'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Text to Speech',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: _textController,
              maxLines: 8,
              onChanged: (_) {
                setState(() {
                  _highlightStart = -1;
                  _highlightEnd = -1;
                  _resumeBaseOffset = 0;
                });
              },
              decoration: InputDecoration(
                hintText: 'Enter text to speak...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Currently spoken word
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(12),
              ),
              child: _buildHighlightedText(),
            ),

            const SizedBox(height: 20),

            // Play / Pause / Stop
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  iconSize: 45,
                  tooltip: 'Play',
                  onPressed: _isPlaying ? null : _playOrResume,
                  icon: const Icon(Icons.play_arrow),
                ),

                const SizedBox(width: 20),

                IconButton(
                  iconSize: 45,
                  tooltip: 'Pause',
                  onPressed: _isPlaying ? _pause : null,
                  icon: const Icon(Icons.pause),
                ),

                const SizedBox(width: 20),

                IconButton(
                  iconSize: 45,
                  tooltip: 'Stop',
                  onPressed: (!_isPlaying && !_isPaused) ? null : _stop,
                  icon: const Icon(Icons.stop),
                ),
              ],
            ),

            const SizedBox(height: 10),

            Center(
              child: Text(
                _isPlaying
                    ? 'Playing'
                    : _isPaused
                        ? 'Paused'
                        : 'Stopped',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),

            const SizedBox(height: 30),

            // Speech Rate
            Row(
              children: [
                const Icon(Icons.speed),
                const SizedBox(width: 10),
                const SizedBox(
                  width: 80,
                  child: Text('Speed'),
                ),
                Expanded(
                  child: Slider(
                    min: 0.1,
                    max: 1.0,
                    divisions: 9,
                    value: _speechRate,
                    onChanged: _setSpeechRate,
                  ),
                ),
                SizedBox(
                  width: 40,
                  child: Text(
                    _speechRate.toStringAsFixed(1),
                  ),
                ),
              ],
            ),

            // Pitch
            Row(
              children: [
                const Icon(Icons.graphic_eq),
                const SizedBox(width: 10),
                const SizedBox(
                  width: 80,
                  child: Text('Pitch'),
                ),
                Expanded(
                  child: Slider(
                    min: 0.5,
                    max: 2.0,
                    divisions: 15,
                    value: _pitch,
                    onChanged: _setPitch,
                  ),
                ),
                SizedBox(
                  width: 40,
                  child: Text(
                    _pitch.toStringAsFixed(1),
                  ),
                ),
              ],
            ),

            // Volume
            Row(
              children: [
                const Icon(Icons.volume_up),
                const SizedBox(width: 10),
                const SizedBox(
                  width: 80,
                  child: Text('Volume'),
                ),
                Expanded(
                  child: Slider(
                    min: 0.0,
                    max: 1.0,
                    divisions: 10,
                    value: _volume,
                    onChanged: _setVolume,
                  ),
                ),
                SizedBox(
                  width: 40,
                  child: Text(
                    _volume.toStringAsFixed(1),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}