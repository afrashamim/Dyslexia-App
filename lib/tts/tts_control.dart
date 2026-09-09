import 'package:flutter/material.dart';

import 'tts_service.dart';
import 'tts_state.dart';

class TtsControls extends StatefulWidget {
  final String text;

  const TtsControls({
    super.key,
    required this.text,
  });

  @override
  State<TtsControls> createState() => _TtsControlsState();
}

class _TtsControlsState extends State<TtsControls> {
  final TtsService _ttsService = TtsService();

  TtsState _state = TtsState.stopped;

  double _speechRate = 0.5;
  double _pitch = 1.0;
  double _volume = 1.0;

  @override
  void initState() {
    super.initState();

    _setupTts();
  }

  Future<void> _setupTts() async {
    await _ttsService.initialize();

    _ttsService.setStartHandler(() {
      if (!mounted) return;

      setState(() {
        _state = TtsState.playing;
      });
    });

    _ttsService.setCompletionHandler(() {
      if (!mounted) return;

      setState(() {
        _state = TtsState.stopped;
      });
    });

    _ttsService.setPauseHandler(() {
      if (!mounted) return;

      setState(() {
        _state = TtsState.paused;
      });
    });

    _ttsService.setContinueHandler(() {
      if (!mounted) return;

      setState(() {
        _state = TtsState.playing;
      });
    });

    _ttsService.setCancelHandler(() {
      if (!mounted) return;

      setState(() {
        _state = TtsState.stopped;
      });
    });

    _ttsService.setErrorHandler((message) {
      if (!mounted) return;

      setState(() {
        _state = TtsState.stopped;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('TTS error: $message'),
        ),
      );
    });
  }

  Future<void> _speak() async {
    if (widget.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter some text first.'),
        ),
      );
      return;
    }

    await _ttsService.speak(widget.text);
  }

  Future<void> _pause() async {
    await _ttsService.pause();
  }

  Future<void> _stop() async {
    await _ttsService.stop();

    if (!mounted) return;

    setState(() {
      _state = TtsState.stopped;
    });
  }

  Future<void> _changeSpeechRate(double value) async {
    setState(() {
      _speechRate = value;
    });

    await _ttsService.setSpeechRate(value);
  }

  Future<void> _changePitch(double value) async {
    setState(() {
      _pitch = value;
    });

    await _ttsService.setPitch(value);
  }

  Future<void> _changeVolume(double value) async {
    setState(() {
      _volume = value;
    });

    await _ttsService.setVolume(value);
  }

  @override
  void dispose() {
    _ttsService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  iconSize: 40,
                  tooltip: 'Play',
                  onPressed: _state == TtsState.playing ? null : _speak,
                  icon: const Icon(Icons.play_arrow),
                ),

                IconButton(
                  iconSize: 40,
                  tooltip: 'Pause',
                  onPressed: _state == TtsState.playing ? _pause : null,
                  icon: const Icon(Icons.pause),
                ),

                IconButton(
                  iconSize: 40,
                  tooltip: 'Stop',
                  onPressed: _state == TtsState.stopped ? null : _stop,
                  icon: const Icon(Icons.stop),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Speech speed
            Row(
              children: [
                const Icon(Icons.speed),
                const SizedBox(width: 8),
                const Text('Speed'),
                Expanded(
                  child: Slider(
                    min: 0.1,
                    max: 1.0,
                    divisions: 9,
                    value: _speechRate,
                    onChanged: _changeSpeechRate,
                  ),
                ),
                Text(_speechRate.toStringAsFixed(1)),
              ],
            ),

            // Pitch
            Row(
              children: [
                const Icon(Icons.graphic_eq),
                const SizedBox(width: 8),
                const Text('Pitch'),
                Expanded(
                  child: Slider(
                    min: 0.5,
                    max: 2.0,
                    divisions: 15,
                    value: _pitch,
                    onChanged: _changePitch,
                  ),
                ),
                Text(_pitch.toStringAsFixed(1)),
              ],
            ),

            // Volume
            Row(
              children: [
                const Icon(Icons.volume_up),
                const SizedBox(width: 8),
                const Text('Volume'),
                Expanded(
                  child: Slider(
                    min: 0.0,
                    max: 1.0,
                    divisions: 10,
                    value: _volume,
                    onChanged: _changeVolume,
                  ),
                ),
                Text(_volume.toStringAsFixed(1)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}