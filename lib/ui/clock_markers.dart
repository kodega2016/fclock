import 'dart:math';

import 'package:flutter/material.dart';

class ClockHand extends StatelessWidget {
  const ClockHand({
    Key? key,
    required this.handHeight,
    required this.handThickness,
    required this.angle,
  }) : super(key: key);

  final double handThickness;
  final double handHeight;
  final double angle;

  @override
  Widget build(BuildContext context) {
    return Transform(
      transform: Matrix4.identity()
        ..translate(-handThickness / 2, 0.0)
        ..rotateZ(angle),
      child: Container(
        height: handHeight,
        width: handThickness,
        color: Colors.grey,
      ),
    );
  }
}

class ClockSecondMarkers extends StatelessWidget {
  const ClockSecondMarkers({
    Key? key,
    required this.radius,
    required this.seconds,
  }) : super(key: key);

  final double radius;
  final int seconds;

  @override
  Widget build(BuildContext context) {
    const height = 12.0;
    const width = 2.0;
    final color = seconds % 5 == 0 ? Colors.white : Colors.grey[700];
    return Transform(
      alignment: Alignment.center,
      transform: Matrix4.identity()
        ..translate(-width / 2, -height / 2, 0.0)
        ..rotateZ(2 * pi * seconds / 60.0)
        ..translate(0.0, radius - height / 2.0),
      child: Container(
        height: height,
        width: width,
        color: color,
      ),
    );
  }
}

class ClockTextMarker extends StatelessWidget {
  const ClockTextMarker({
    Key? key,
    required this.radius,
    required this.maxValue,
    required this.value,
  }) : super(key: key);

  final int value;
  final int maxValue;
  final double radius;

  @override
  Widget build(BuildContext context) {
    const height = 30.0;
    const width = 40.0;
    return Transform(
      alignment: Alignment.center,
      transform: Matrix4.identity()
        ..translate(-width / 2, -height / 2, 0.0)
        ..rotateZ(pi + 2 * pi * value / maxValue)
        ..translate(0.0, radius - 40)
        ..rotateZ(pi - 2 * pi * (value / maxValue)),
      child: SizedBox(
        height: height,
        width: width,
        child: Text(
          value.toString(),
          style: const TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
