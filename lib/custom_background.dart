import 'dart:ui' as ui;
import 'package:repeat_mehrdadproject/app_properties.dart';
import 'package:flutter/material.dart';

class AuthBackground extends CustomPainter {
  AuthBackground({
    this.image,
  });

  ui.Image image;

  @override
  void paint(Canvas canvas, Size size) {
   if(image!=null)
    canvas.drawImage(image, new Offset(0.0, 0.0), new Paint());
   canvas.drawRect(Rect.fromLTRB(0, 0, size.width, size.height), Paint()..color = transparentYellow);
  }

    @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class MainBackground extends CustomPainter {

  MainBackground();

  @override
  void paint(Canvas canvas, Size size) {
    double height = size.height;
    double width = size.width;
canvas.drawRect(
        Rect.fromLTRB(
            0, 0,width, height),
        Paint()..color = Colors.deepOrange);
    var path = Path();

    path.moveTo(width , size.height/6);
    path.lineTo(0, size.height*(5/6));
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.close();
    var s=Paint();
    s..color=Colors.blue;
    s..style= PaintingStyle.fill;

    canvas.drawPath(path,s);



    canvas.drawRect(
        Rect.fromLTRB(
            width - (width / 4), 0,width, height),
        Paint()..color = blu_purple1);
        
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
