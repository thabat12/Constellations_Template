import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_website/physics/node_handler.dart';
import 'package:flutter_website/widgets/icon_chip.dart';
import 'package:flutter_website/widgets/section.dart';
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

    const TextStyle smallFontHeader = TextStyle(
      letterSpacing: 0.5,
      height: 1.3,
      color: Colors.white,
      fontSize: 20,
    );

    return Scaffold(
      backgroundColor: Colors.black,
      body: Scrollbar(
        isAlwaysShown: true,
        radius: Radius.circular(15),
        thickness: 15,
        showTrackOnHover: true,
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              Stack(
                children: [
                  ChangeNotifierProvider(
                    create: (ctx) => NodeHandler(50, BoxConstraints(maxWidth: 0.0, maxHeight: 0.0)),
                    child: Container(
                        height: MediaQuery.of(context).size.height * 0.85,
                        child: LayoutBuilder(
                          builder: (BuildContext context, BoxConstraints constraints) {
                            Provider.of<NodeHandler>(context).updateConstraints(constraints);
                            return MyCanvas(constraints);
                          },
                        )
                    ),
                  ),
                  Positioned(
                    left: MediaQuery.of(context).size.width * 0.10,
                      top: MediaQuery.of(context).size.height * 0.15,
                      child: SelectableText.rich(
                          TextSpan(
                              text: 'Hello there! I\'m\n',
                              style: smallFontHeader,
                            children: <TextSpan>[
                              TextSpan(
                                text: '[Name Here]',
                                style: TextStyle(
                                  color: Colors.greenAccent,
                                  fontSize: 50,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(
                                text: '.\n\n\n',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 50,
                                  fontWeight: FontWeight.bold,
                                ),
                              )

                            ]
                      ),

                      )
                  ),
                  Positioned(
                    right: MediaQuery.of(context).size.width * 0.10,
                    bottom: MediaQuery.of(context).size.height * 0.10,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconChip('l.png', Colors.blue),
                        IconChip('githubWhite.png', Colors.deepPurple),
                        IconChip('youtubeLogo.png', Colors.red),
                      ],
                    ),
                  )
                ],
              ),
              Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.10,
                    ),
                    alignment: Alignment.topLeft,
                    color: Colors.black,
                    child: Column(
                      children: [
                        SelectableText.rich(
                          TextSpan(
                            text: '01\n',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.white,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: 'Projects',
                                style: TextStyle(
                                  color: Colors.greenAccent,
                                  fontSize: 35,
                                  fontWeight: FontWeight.bold,
                                )
                              )
                            ]
                          ),
                        ),
                      ],
                    ),
                  ),
                  Section(),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}