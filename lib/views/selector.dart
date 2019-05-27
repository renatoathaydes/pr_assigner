import 'package:flutter_web/material.dart';

class Selector extends StatefulWidget {
  Selector({Key key}) : super(key: key);

  @override
  SelectorState createState() => SelectorState();
}

class SelectorState extends State<Selector> {
  @override
  void initState() {
    super.initState();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      new Row(children: <Widget>[
        new Icon(Icons.menu, size: 32.0, color: Colors.blueGrey),
        new Expanded(
          child: new Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: new Text(
              "Timeline",
              style: new TextStyle(
                  fontSize: 20.0,
                  color: Colors.blueGrey,
                  fontWeight: FontWeight.w300),
            ),
          ),
        ),
        new Icon(Icons.linear_scale, color: Colors.blueGrey),
      ]),
    ]);
  }
}
