import "package:trainning/recursos/MyPainter.dart";
import "package:flutter/material.dart";

class Dibujador extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 200,
        width: 200,
        color: Colors.grey,
        child: CustomPaint(
          painter: MyPainter(),
        ),
    
    );
  }
}

