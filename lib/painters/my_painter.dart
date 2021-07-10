import 'dart:ui' as ui;
import 'dart:math';
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

    List<Node> nodes = nodeHandler.getNodes;
    List<Offset> nodeOffsets = nodeHandler.getPoints;

    for (int i = 0; i < nodes.length; i++) {
      canvas.drawCircle(
            nodeOffsets[i],
            (nodes[i].isLarge) ? 2.5 : 1.75,
            node_paint
      );
    }


    // canvas.drawPoints(ui.PointMode.points, nodeHandler.getPoints, node_paint);

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