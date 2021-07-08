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
        nodes[i] = new Node();
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
        nodes[i] = new Node();
      } else {

        double dist =  nodes[i].calculateDistanceFromMouseWithFactor(mouseX / maxW, mouseY/ maxH);

        // input the total distance to move, the mouseX and mouseY coordinates
        if (dist < radiusFromMouse) {
          print('contact');
          double diff = radiusFromMouse - dist;
          nodes[i].moveNodeFromMouseWithFactor(mouseX/ maxW, mouseY/ maxH, diff);
        }

        nodes[i].step();

        print('xpos is ${nodes[i].xpos} and ypos is ${nodes[i].ypos}');

      }
    }



    notifyListeners();
  }

  // dynamic calculations with constraint resizing
  void updateConstraints(BoxConstraints newConstraint) {
    maxH = newConstraint.maxHeight;
    maxW = newConstraint.maxWidth;
  }

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

}