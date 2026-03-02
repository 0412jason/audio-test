import 'package:flutter/material.dart';
import 'dart:collection';

class WaveformPainter extends CustomPainter {
  final Queue<double> amplitudes;
  final Color color;

  WaveformPainter({required this.amplitudes, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    if (amplitudes.isEmpty) return;

    final paint = Paint()
      ..color = color
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final path = Path();
    final width = size.width;
    final height = size.height;
    final centerY = height / 2;

    final List<double> ampsList = amplitudes.toList();
    final pointCount = ampsList.length;
    
    if (pointCount < 2) return;

    final dx = width / (pointCount - 1);

    path.moveTo(0, centerY - (ampsList[0] * centerY));

    for (int i = 1; i < pointCount; i++) {
        final x = i * dx;
        final y = centerY - (ampsList[i] * centerY);
        path.lineTo(x, y);
    }
    
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant WaveformPainter oldDelegate) {
    return true;
  }
}
