import 'package:flutter/material.dart';
import 'package:flutter_website/physics/node.dart';
import 'package:flutter_website/physics/node_handler.dart';


import 'package:provider/provider.dart';


import '../painters/my_painter.dart';
import '../physics/node_handler.dart';
class MyCanvas extends StatefulWidget {

  BoxConstraints constraints;

  MyCanvas(this.constraints);

  @override
  _MyCanvasState createState() => _MyCanvasState();
}

class _MyCanvasState extends State<MyCanvas> with SingleTickerProviderStateMixin {

  late AnimationController _controller;

  double xpos = 0.0;
  double ypos = 0.0;


  late NodeHandler _nodeHandler;
  late Animation _animation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 1)
    );

    _animation = CurvedAnimation(parent: _controller, curve: Curves.linear)
      ..addStatusListener((status) {

        if (status == AnimationStatus.completed) {

          setState(() {
            _nodeHandler.updateWithMouse(xpos, ypos, 0.10);
          });
          _controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          setState(() {
            _nodeHandler.updateWithMouse(xpos, ypos, 0.10);
          });
          _controller.forward();
        }
      });

    _controller.forward();

  }



  @override
  Widget build(BuildContext context) {

    _nodeHandler = Provider.of<NodeHandler>(context);

    return MouseRegion(
        onHover: (event) {
          xpos = event.localPosition.dx;
          ypos = event.localPosition.dy;
          // _nodeHandler.updateWithMouse(xpos, ypos, 0.06);
        },
        child: Container(
          width: widget.constraints.maxWidth,
          height: widget.constraints.maxHeight,
          child: CustomPaint(
            willChange: true,
            painter: MyPainter(nodeHandler: _nodeHandler),
          ),
        )
    );
  }


  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }


}
