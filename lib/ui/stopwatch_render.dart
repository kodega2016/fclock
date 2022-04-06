import 'dart:math';

import 'package:fclock/ui/clock_markers.dart';
import 'package:flutter/material.dart';

class StopWatchRender extends StatelessWidget {
  const StopWatchRender({
    Key? key,
    required this.elapsed,
    required this.radius,
  }) : super(key: key);

  final Duration elapsed;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        for (int i = 0; i < 60; i++)
          Positioned(
            left: radius,
            top: radius,
            child: ClockSecondMarkers(
              radius: radius,
              seconds: i,
            ),
          ),
        for (int i = 5; i <= 60; i += 5)
          Positioned(
            left: radius,
            top: radius,
            child: ClockTextMarker(
              radius: radius,
              maxValue: 60,
              value: i,
            ),
          ),
        Positioned(
          left: radius,
          top: radius,
          child: ClockHand(
            handHeight: radius,
            handThickness: 2,
            angle: pi + 2 * pi / 60000 * elapsed.inMilliseconds,
          ),
        ),
      ],
    );
  }
}
