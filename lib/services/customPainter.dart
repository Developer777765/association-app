import 'package:flutter/material.dart';

class CustomPainterOf extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.white.withOpacity(0.2)
      ..style = PaintingStyle.fill;

    final Path path = Path();
    path.moveTo(size.width, size.height * 0.2);
    // path.quadraticBezierTo(
    //   size.width * 0.75, // Control point X (adjust this for curvature)
    //   size.height *
    //       0.1, // Control point Y (move this closer to the triangle point)
    //   size.width / 3, // End point X (middle point)
    //   size.height * 0.5, // End point Y (triangle base near logo)
    // );
    path.lineTo(size.width / 2.5, size.height / 2);
    path.lineTo(size.width, size.height * 0.8);
    // path.lineTo(size.width, size.height * 0.3);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
