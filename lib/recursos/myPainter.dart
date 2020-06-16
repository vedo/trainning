import 'package:flutter/material.dart';

class MyPainter extends CustomPainter {

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = new Paint();
    paint.color = Colors.redAccent;
    canvas.drawCircle(Offset(size.width/2,size.height/2), size.height/2, paint);
  }

  @override
  bool shouldRepaint(MyPainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(MyPainter oldDelegate) => false;
}

