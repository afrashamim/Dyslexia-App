import 'package:flutter/material.dart';

class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final w = size.width;
    final h = size.height;
    final path = Path();
    path.lineTo(w, 0);
    path.lineTo(w, h * 0.69);
    path.cubicTo(
      w * 0.767, h * 0.92,
      w * 0.633, h * 0.46,
      w * 0.5, h * 0.69,
    );
    path.cubicTo(
      w * 0.367, h * 0.92,
      w * 0.233, h * 0.46,
      0, h * 0.73,
    );
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}