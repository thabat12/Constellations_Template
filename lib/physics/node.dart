import 'dart:math';


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

    Random random = new Random();

    // pick the position
    Where pos = Where.values[random.nextInt(Where.values.length)];

    if (pos == Where.top || pos == Where.bottom) {
      xpos = random.nextDouble() * 0.9 + 0.05;
      ypos = (pos == Where.top) ? 0.0 : 0.99;


      dx = (xpos < 0.5) ? 0.0009 : -0.0009;
      dy = (ypos < 0.5) ? 0.0009 : -0.0009;

      dx *= random.nextDouble();
      dy *= random.nextDouble();

    } else if (pos == Where.left || pos == Where.right) {
      ypos = random.nextDouble() * 0.9 + 0.05;
      xpos = (pos == Where.left) ? 0.0 : 0.99;

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

  void step() {
    xpos += dx;
    ypos += dy;
  }

  double calculateDistanceFromNode(Node other) {
    return sqrt( pow(xpos - other.getX, 2) + pow(ypos - other.getY, 2));
  }

  double calculateDistanceFromMouseWithFactor(double mouseX, double mouseY) {
    return sqrt( pow(xpos - mouseX, 2) + pow(ypos - mouseY, 2));
  }

  double calculateDistanceFromCenter() {
    return sqrt( pow(xpos - 0.5, 2) + pow(ypos - 0.5, 2));
  }

  void moveNodeFromMouseWithFactor(double mouseX, double mouseY, double distance) {

    double xDiff = (mouseX - xpos);
    double yDiff = (mouseY - ypos);


    double rad = atan( ( mouseY - ypos) /  (mouseX - xpos) );

    double moveX = (mouseX < xpos) ? cos(rad) * distance : -cos(rad) * distance;
    double moveY = (mouseY > ypos) ? sin(rad) * distance : -sin(rad) * distance;

    // TODO: very strange problem, basically when the node reaches the intersection of lim^-1 -> pi/2
    // it jumps down, but when switch the signs up then the problem occurs on the OPPOSITE side


    _updateXDiff(moveX);
    _updateYDiff(moveY);

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