import 'package:flutter_web/material.dart';

import 'src/views/selector.dart';

void main() => runApp(PrAssigner());

class PrAssigner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PR Assigner',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        fontFamily: 'Arial',
        textTheme: TextTheme(
          headline: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          title: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
          body1: TextStyle(fontSize: 14.0, fontFamily: 'Arial'),
        ),
      ),
      home: RepoSelector(),
    );
  }
}
