import 'dart:math' as math;


import 'package:flutter/material.dart';

enum Where {
  top,
  bottom,
  left,
  right
}


class Node {

  late double xpos, ypos, dy, dx;
  late bool large;


  Node() {

    math.Random random = new math.Random();

    // pick the position
    Where pos = Where.values[random.nextInt(Where.values.length)];

    if (pos == Where.top || pos == Where.bottom) {
      xpos = random.nextDouble() * 0.9 + 0.05;
      ypos = (pos == Where.top) ? random.nextDouble() * 0.50
      : 0.50 + random.nextDouble() * 0.50;


      dx = (xpos < 0.5) ? 0.0009 : -0.0009;
      dy = (ypos < 0.5) ? 0.0009 : -0.0009;

      dx *= random.nextDouble();
      dy *= random.nextDouble();

    } else if (pos == Where.left || pos == Where.right) {
      ypos = random.nextDouble() * 0.9 + 0.05;
      xpos = (pos == Where.left) ? random.nextDouble() * 0.50
          : 0.50 + random.nextDouble() * 0.50;

      double tiltFac = random.nextDouble();

      dx = (xpos < 0.5) ? 0.0009 : -0.0009;
      dy = (ypos < 0.5) ? 0.0009 : -0.0009;

      dx *= random.nextDouble();
      dy *= random.nextDouble();
    }

    large = random.nextBool();


  }

  double get getX => xpos;
  double get getY => ypos;
  bool get isLarge => large;

  void step() {
    xpos += dx;
    ypos += dy;
  }

  double calculateDistanceFromNode(Node other) {
    return math.sqrt( math.pow(xpos - other.getX, 2) + math.pow(ypos - other.getY, 2));
  }

  double calculateDistanceFromMouseWithFactor(double mouseX, double mouseY) {
    return math.sqrt( math.pow(xpos - mouseX, 2) + math.pow(ypos - mouseY, 2));
  }

  double calculateDistanceFromCenter() {
    return math.sqrt(math.pow(xpos - 0.5, 2) + math.pow(ypos - 0.5, 2));
  }

  void moveNodeFromMouseWithFactor(double mouseX, double mouseY, double distance) {
    double rad = math.atan( (mouseY - ypos) /  (mouseX - xpos) );

    double xVec = distance * math.cos(rad);
    double yVec = distance * math.sin(rad);

    if ((mouseX > xpos && mouseY > ypos) || (mouseX > xpos && mouseY < ypos)) {
      xVec *= -1;
      yVec *= -1;
    }

    _updateXDiff(xVec);
    _updateYDiff(yVec);

  }



  void _updateXDiff(double diff) {
    xpos += diff;
  }

  void _updateYDiff(double diff) {
    ypos += diff;
  }


  /*
  * functions:
  *   get xpos and ypos
  *   find length and link weights
  *   make a spawn object based on constraints
  *   calculate proper direction and speed based on dx, dy
  *   change dx and dy based on pointer selections (HARDEST PROBLEM)
  */
}