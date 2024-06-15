import 'dart:math';

import 'package:flutter/material.dart';

class StarPainter extends CustomPainter {
  final Animation<double> animation;

  StarPainter({required this.animation}) : super(repaint: animation);
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = Colors.white.withOpacity(0.5);
    paint.strokeWidth = 2;
    paint.style = PaintingStyle.fill;

    var random = Random(animation.value.toInt());

    // Dibuja 100 estrellitas en posiciones aleatorias
    for (int i = 0; i < 100; i++) {
      var x = random.nextDouble() * size.width;
      var y = random.nextDouble() * size.height;
      drawStar(canvas, x, y, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

  void drawStar(Canvas canvas, double x, double y, Paint paint) {
    const numberOfPoints = 2;
    const size = 7.0;
    const halfSize = size / 2;
    const double degreesPerStep = pi / numberOfPoints;
    const double halfDegreesPerStep = degreesPerStep / 2;
    final path = Path();
    const fullAngle = 2 * pi;
    path.moveTo(x + cos(0) * size, y + sin(0) * size);
    for (double step = 0; step < fullAngle; step += degreesPerStep) {
      path.lineTo(x + cos(step + halfDegreesPerStep) * halfSize,
          y + sin(step + halfDegreesPerStep) * halfSize);
      path.lineTo(x + cos(step + degreesPerStep) * size,
          y + sin(step + degreesPerStep) * size);
    }
    path.close();
    canvas.drawPath(path, paint);
  }
}
