import 'package:flutter/material.dart';

class BnbCustomPainter extends CustomPainter {
  final Size screenSize;

  BnbCustomPainter({super.repaint, required this.screenSize});
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.yellow.shade50
      ..style = PaintingStyle.fill;
    Path path = Path()..moveTo(0, 20);
    path.quadraticBezierTo(
      screenSize.width * 0.20,
      0,
      screenSize.width * 0.35,
      0,
    );
    path.quadraticBezierTo(
      screenSize.width * 0.40,
      0,
      screenSize.width * 0.40,
      20,
    );
    path.arcToPoint(
      Offset(
        screenSize.width * 0.60,
        20,
      ),
      radius: const Radius.circular(10.0),
      clockwise: false,
    );
    path.quadraticBezierTo(
      screenSize.width * 0.60,
      0,
      screenSize.width * 0.65,
      0,
    );
    path.quadraticBezierTo(
      screenSize.width * 0.80,
      0,
      screenSize.width,
      20,
    );
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    canvas.drawShadow(path, Colors.black54, 5, true);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(CustomPainter oldDelegate) => false;
}
