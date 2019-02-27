import 'package:flutter/material.dart';

class Circle extends CustomPainter {

  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5;

    canvas.drawCircle(Offset(size.width / 2, size.height / 2), size.width / 2, paint);
  }

  bool shouldRepaint(Circle oldCircle) => false;
}
