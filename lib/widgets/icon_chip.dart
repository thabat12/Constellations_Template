import 'package:flutter/material.dart';

import 'package:glassmorphism/glassmorphism.dart';

class IconChip extends StatefulWidget {

  String image_addr;
  Color selected_color;
  IconChip(this.image_addr, this.selected_color);

  @override
  _IconChipState createState() => _IconChipState();
}

class _IconChipState extends State<IconChip> with SingleTickerProviderStateMixin {

  late AnimationController _controller;
  late Animation<double> _curve;
  late Animation _colorAnimate;
  late Animation _grayToTranparent;

  @override
  void initState() {
    _controller = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 250)
    );

    _curve = CurvedAnimation(
        parent: _controller,
        curve: Curves.easeIn);

    _colorAnimate = ColorTween(
      begin: Colors.white,
      end: Colors.orange,
    ).animate(_curve)
    // so this thing will force rebuild each time
    ..addListener(() {
      setState(() {

      });
    });


  }


  bool isSelected = false;


  void _flipSelected() {
    print(isSelected);
    setState(() {
      isSelected = !isSelected;
    });
  }


  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        _controller.forward();
        _flipSelected();
      },
      onExit: (_) {
        _controller.reverse();
        _flipSelected();
      },
      child: AnimatedContainer(
        height: 30,
        width: 55,
        padding: EdgeInsets.only(
          top: 2.5,
          bottom: 2.5,
        ),
        margin: EdgeInsets.only(
          left: 5.0
        ),
        duration: Duration(milliseconds: 100),
        decoration: BoxDecoration(
          color: (isSelected) ? widget.selected_color : Colors.white,
          borderRadius: BorderRadius.circular(5.0)
        ),
        child: Image.asset(
            widget.image_addr,
          color: Colors.black,
        ),
      ),
    );
  }
}
