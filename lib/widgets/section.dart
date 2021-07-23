import 'package:flutter/material.dart';
import 'package:flutter_website/widgets/project_tile.dart';


class Section extends StatefulWidget {
  const Section({Key? key}) : super(key: key);

  @override
  _SectionState createState() => _SectionState();
}

class _SectionState extends State<Section> {

  int counter = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridView.count(
        // shrinkWrap will make it wrap to child contents ez
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        childAspectRatio: 1.0,
        crossAxisCount: 2,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
        padding: EdgeInsets.only(
          left:  MediaQuery.of(context).size.width * 0.10,
          right:  MediaQuery.of(context).size.width * 0.10,
          top: 15,
        ),
        children: [
          ProjectTile(),
          ProjectTile(),
          ProjectTile(),
        ],
      ),
    );
  }
}
