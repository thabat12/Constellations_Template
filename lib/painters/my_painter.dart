import 'dart:ui' as ui;
// https://api.flutter.dev/flutter/dart-ui/dart-ui-library.html

import 'package:flutter/material.dart';


import 'package:flutter_website/physics/node.dart';
import 'package:flutter_website/physics/node_handler.dart';

class MyPainter extends CustomPainter with ChangeNotifier {

  late NodeHandler nodeHandler;

  MyPainter({required this.nodeHandler});



  @override
  void paint(Canvas canvas, Size size) {

    final node_paint = Paint()
    ..strokeWidth = 5.0
    ..color = Colors.white
    ..strokeCap = StrokeCap.round;



    canvas.drawPoints(ui.PointMode.points, nodeHandler.getPoints, node_paint);

    // now iterate to draw lines for node connections
    // so i just need a list of Offset values
    List<List<dynamic>> connections = nodeHandler.linesWithOpacityFactor;
    for (int i = 0; i < connections.length; i++) {
      canvas.drawLine(connections[i][0], connections[i][1],
      new Paint()
          ..color = Color.fromRGBO(255, 255, 255, connections[i][2])
          ..strokeWidth = 1.0
          ..strokeCap = StrokeCap.round
      );
    }

  }


  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

}