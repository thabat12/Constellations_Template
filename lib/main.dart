import 'package:flutter/material.dart';
import 'package:flutter_website/physics/node_handler.dart';
import 'package:provider/provider.dart';

import 'widgets/canvas.dart';

import 'painters/my_painter.dart';

void main() {
  runApp(WebApp());
}

class WebApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'abhinav cool boy',
      initialRoute: '/',
      routes: {
        '/': (ctx) => HomePage(),
      },
    );
  }
}

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(64, 64, 64, 1.0),
      body: ChangeNotifierProvider(
        create: (ctx) => NodeHandler(20, BoxConstraints(maxWidth: 0.0, maxHeight: 0.0)),
        child: Container(
          // padding: EdgeInsets.all(30.0),
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              Provider.of<NodeHandler>(context).updateConstraints(constraints);
              return MyCanvas(constraints);
            },

          )
        ),
      ),
    );
  }
}





