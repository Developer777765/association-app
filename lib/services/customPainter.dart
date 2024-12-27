import 'package:flutter/material.dart';

class CustomPainterOf extends CustomPainter {
  final Color color;
  final double controlPoint1X;
  final double controlPoint2X;
  final double waveHeight;

  CustomPainterOf({
    required this.color,
    required this.controlPoint1X,
    required this.controlPoint2X,
    required this.waveHeight,
  });
  @override
  void paint(Canvas canva, Size size) {
    var paint = Paint()
      ..color = color
      ..strokeWidth = 15;

    var path = Path();

    path.moveTo(0, size.height * 0.7);
    path.quadraticBezierTo(
      size.width * controlPoint1X,
      size.height * waveHeight,
      size.width * 0.5,
      size.height * 0.8,
    );
    path.quadraticBezierTo(
      size.width * controlPoint2X,
      size.height * 0.9,
      size.width,
      size.height * 0.8,
    );
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canva.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
