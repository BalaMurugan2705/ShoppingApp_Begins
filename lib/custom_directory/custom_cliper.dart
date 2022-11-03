import 'package:flutter/material.dart';

class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    var sw = size.width;
    var sh = size.height;

    path.cubicTo(sw / 20, 0, sw / 20, 2 * sh / 5, 2 * sw / 20, 2 * sh / 5);
    path.cubicTo(3 * sw / 20, 2 * sh / 5, 3 * sw / 20, 0, 4 * sw / 20, 0);
    path.cubicTo(
        5 * sw / 20, 0, 5 * sw / 20, 2 * sh / 5, 6 * sw / 20, 2 * sh / 5);
    path.cubicTo(7 * sw / 20, 2 * sh / 5, 7 * sw / 20, 0, 8 * sw / 20, 0);
    path.cubicTo(
        9 * sw / 20, 0, 9 * sw / 20, 2 * sh / 5, 10 * sw / 20, 2 * sh / 5);
    path.cubicTo(11 * sw / 20, 2 * sh / 5, 11 * sw / 20, 0, 12 * sw / 20, 0);
    path.cubicTo(
        13 * sw / 20, 0, 13 * sw / 20, 2 * sh / 5, 14 * sw / 20, 2 * sh / 5);
    path.cubicTo(15 * sw / 20, 2 * sh / 5, 15 * sw / 20, 0, 16 * sw / 20, 0);
    path.cubicTo(
        17 * sw / 20, 0, 17 * sw / 20, 2 * sh / 5, 18 * sw / 20, 2 * sh / 5);
    path.cubicTo(19 * sw / 20, 2 * sh / 5, 19 * sw / 20, 0, sw, 0);
    path.lineTo(sw, sh);
    path.lineTo(0, sh);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
