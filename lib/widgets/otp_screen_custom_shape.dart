import 'package:flutter/material.dart';

import 'dart:ui' as ui;


//Copy this CustomPainter code to the Bottom of the File
class RPSCustomPainter extends CustomPainter {
    @override
    void paint(Canvas canvas, Size size) {
      Paint paint_0_fill = Paint()..style=PaintingStyle.fill;
      paint_0_fill.shader = ui.Gradient.linear(Offset(size.width*0.8794872,size.height*0.03044872), Offset(size.width*0.7448718,size.height*0.8878205), [Color(0xff00AB4E).withOpacity(1),Color(0xffA8D930).withOpacity(0)], [0,1]);
      canvas.drawCircle(Offset(size.width*0.7448718,size.height*0.2355769),size.width*0.5217949,paint_0_fill);

      Paint paint_1_fill = Paint()..style=PaintingStyle.fill;
      paint_1_fill.shader = ui.Gradient.linear(Offset(size.width*0.4820513,size.height*0.1426282), Offset(size.width*0.3474359,size.height), [Color(0xff00AB4E).withOpacity(1),Color(0xffA8D930).withOpacity(0)], [0,1]);
      canvas.drawCircle(Offset(size.width*0.3474359,size.height*0.3477564),size.width*0.5217949,paint_1_fill);

    }

    @override
    bool shouldRepaint(covariant CustomPainter oldDelegate) {
        return true;
    }
}



