import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';

class ProjectTile extends StatefulWidget {
  const ProjectTile({Key? key}) : super(key: key);

  @override
  _ProjectTileState createState() => _ProjectTileState();
}

class _ProjectTileState extends State<ProjectTile> with SingleTickerProviderStateMixin {

  final _duration = Duration(milliseconds: 100);
  late SizeTween _sizeAnimate;

  late AnimationController _controller;
  late CurvedAnimation _animation;

  // on hover checks
  bool _isActive = false;



  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
    duration: Duration(milliseconds: 100)
    );

    _animation = CurvedAnimation(
        parent: _controller,
        curve: Curves.easeIn);

    _controller.forward();
  }


  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(

      builder: (BuildContext context, BoxConstraints constraints) {

        // init the sizetween here once constraints update
        _sizeAnimate = SizeTween(
          begin: Size(
              (_isActive) ? constraints.maxWidth : constraints.maxWidth * 0.95,
              (_isActive) ? constraints.maxHeight : constraints.maxHeight * 0.95
          )
        );

        return MouseRegion(
          onEnter: (pointerEvent) {
            print('enter');
          },
          onExit: (pointerEvent) {
            print('exit');
          },
          child: AnimatedContainer(
              width: _sizeAnimate.evaluate(_animation)!.width,
              height: _sizeAnimate.evaluate(_animation)!.height,
              duration: _duration,
              margin: EdgeInsets.all(5.0),
              color: Colors.white,
              child: Stack(
                children: [
                  Positioned.fill(
                    bottom: 0.0,
                    left: 0.0,
                    right: 0.0,
                    child: Image.asset(
                      'test.png',
                      scale: 2.0,
                    ),
                  ),
                  PositionedDirectional(
                    bottom: 0.0,
                    end: 0.0,
                    start: 0.0,
                    top: null,
                    child: Container(
                      color: Colors.black38,
                      height: constraints.maxHeight * 0.3,
                    )

                  )
                ],
              )
          ),
        );
      },

    );
  }
}
