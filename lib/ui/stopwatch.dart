import 'package:fclock/ui/reset_button.dart';
import 'package:fclock/ui/start_stop_button.dart';
import 'package:fclock/ui/stopwatch_render.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class StopWatch extends StatefulWidget {
  const StopWatch({Key? key}) : super(key: key);

  @override
  State<StopWatch> createState() => _StopWatchState();
}

class _StopWatchState extends State<StopWatch>
    with SingleTickerProviderStateMixin {
  Duration _preDuration = Duration.zero;
  Duration _elapsedDuration = Duration.zero;

  Duration get duration => _preDuration + _elapsedDuration;

  late Ticker _ticker;
  bool _isRunning = false;

  @override
  void initState() {
    _ticker = Ticker((duration) {
      _elapsedDuration = duration;
      setState(() {});
    });
    super.initState();
  }

  void _toggleStart() {
    _isRunning = !_isRunning;
    if (_isRunning) {
      _ticker.start();
    } else {
      _ticker.stop();
    }
    _preDuration += _elapsedDuration;
    _elapsedDuration = Duration.zero;

    setState(() {});
  }

  void _reset() {
    _isRunning = false;
    _ticker.stop();
    _elapsedDuration = Duration.zero;
    _preDuration = Duration.zero;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Stack(
        children: [
          StopWatchRender(
            elapsed: duration,
            radius: constraints.maxWidth / 2,
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: SizedBox(
              height: 80,
              width: 80,
              child: ResetButton(onPressed: _reset),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: SizedBox(
              height: 80,
              width: 80,
              child: StartStopButton(
                isRunning: _isRunning,
                onPressed: _toggleStart,
              ),
            ),
          ),
        ],
      );
    });
  }
}
