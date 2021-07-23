import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'node.dart';


// The NodeHandler class will manage the states of nodes, interpret values for the canvas, and
// manage the interactivity/ physics of the objects

// Why am I using ChangeNotifierProvider now? Because this instance needs to be accessed by multiple sources:
// like the Canvas as well as the Mouse Region check area. So it makes the most sense to reuse the same instance
// of the provider. Let's see what happens lol.
class NodeHandler with ChangeNotifier {

  late List<Node> nodes;
  late double maxH, maxW;
  final double distanceFromMouseRadiusLol = 0.25;

  NodeHandler(int size, BoxConstraints constraints) {

    maxH = constraints.maxHeight;
    maxW = constraints.maxWidth;

    // list.generate is pretty cool lol
    nodes = List.generate(size, (index) => new Node());
  }


  // very simple update method for simple physics
  void update() {

    for (int i = 0; i < nodes.length; i++) {
      double xpos = nodes[i].getX;
      double ypos = nodes[i].getY;

      // recycle if out of bounds
      if (xpos < 0.0 || xpos >= 1.0 || ypos < 0.0 || ypos >= 1.0) {
        nodes[i] = new Node.fromEdge();
      } else {
        nodes[i].step();
      }


    }

    // notifyListeners();

  }

  // update the coordinates as well as correcting with mouse positions
  void updateWithMouse(double mouseX, double mouseY, double radiusFromMouse) {
    for (int i = 0; i < nodes.length; i++) {
      double xpos = nodes[i].getX;
      double ypos = nodes[i].getY;
      // recycle if out of bounds
      if (xpos < 0.0 || xpos >= 1.0 || ypos < 0.0 || ypos >= 1.0) {
        nodes[i] = new Node.fromEdge();
      } else {

        // TODO: FIX THE DILATION ERROR WHEN THE MAX WIDTH AND MAX HEIGHT ARE NOT EQUAL AND LEADS TO OVAL SHAPED CURSORS
        double mouseXF = 1, mouseYF = 1;
        if (maxH > maxW) {
          mouseXF *= (maxH / maxW);
        } else if (maxW > maxH) {
          mouseYF *= (maxW / maxH);
        }

        // print('maxW: $maxW \t maxH: $maxH \t tempMouseX: $mouseXF \t tempMouseY: $mouseYF');

        double dist =  nodes[i].calculateDistanceFromMouseWithFactor(mouseX / maxW, mouseY/ maxH);

        // input the total distance to move, the mouseX and mouseY coordinates
        if (dist < radiusFromMouse) {
          double diff = radiusFromMouse - dist;
          nodes[i].moveNodeFromMouseWithFactor(mouseX: mouseX/ maxW, mouseY: mouseY/ maxH, distance: diff);
        }

        nodes[i].step();

      }
    }



    // notifyListeners();
  }

  // dynamic calculations with constraint resizing
  void updateConstraints(BoxConstraints newConstraint) {
    maxH = newConstraint.maxHeight;
    maxW = newConstraint.maxWidth;
  }


  // this will calculate each pair of connections with 1 & 2 as Offset values
  // 3 will be the distance between these connections so we can calculate the
  // lines or opacity factors to draw in between them. This is possible with the
  // dynamic data type in Flutter.

  List<List<dynamic>> get linesWithOpacityFactor {

    List<List<dynamic>> connections = List.empty(growable: true);

    for (int i = 0; i < nodes.length - 1; i++) {
      Node curr = nodes[i];
      for (int j = i + 1; j < nodes.length; j++) {
        Node compare = nodes[j];

        double dist = curr.calculateDistanceFromNode(compare);


        if (dist < 0.15) {
          Offset currOfst = new Offset(curr.getX * maxW, curr.getY * maxH);
          Offset compOfst = new Offset(compare.getX * maxW, compare.getY * maxH);
          connections.add([currOfst, compOfst, 100 * ((0.15 - dist) / 15)]);
        }
      }
    }

    return connections;
  }


  // translate to canvas offset values
  List<Offset> get getPoints {
    return nodes.map((node) => Offset(node.getX * maxW, node.getY * maxH)).toList();
  }

  List<Node> get getNodes {
    return nodes;
  }

}