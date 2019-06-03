import 'package:flutter_web/material.dart';
import 'package:flutter_web/widgets.dart';

import '../util/data.dart';

class PullRequests extends StatefulWidget {
  PullRequests({Key key, @required this.title, @required this.pullRequests})
      : super(key: key);

  final String title;
  final List<PullRequest> pullRequests;

  @override
  PullRequestsState createState() => PullRequestsState(pullRequests);
}

class PullRequestsState extends State<PullRequests> {
  String errorMessage;
  final List<PullRequest> pullRequests;
  int timeToGet = 0;

  PullRequestsState(this.pullRequests);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Column(
          children: <Widget>[
            Container(
                alignment: AlignmentDirectional.topStart,
                padding: const EdgeInsets.all(20.0),
                child: Text(
                    "There are currently ${pullRequests.length} pull requests",
                    style:
                        TextStyle(fontStyle: FontStyle.italic, fontSize: 18))),
            Flexible(
                child: ListView(
              padding: const EdgeInsets.all(20.0),
              children: pullRequests.map(pullRequestWidget).toList(),
            ))
          ],
        ));
  }

  Widget pullRequestWidget(PullRequest pull) => Container(
      height: 90.0,
      padding: const EdgeInsets.all(5),
      child: Column(
        children: <Widget>[
          Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                DecoratedBox(
                    decoration: BoxDecoration(color: Colors.deepPurple[100]),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(pull.title),
                    ))
              ]),
          pullRequestDescriptor(pull),
        ],
      ));
}

Widget pullRequestDescriptor(PullRequest pull) => DecoratedBox(
    decoration:
        BoxDecoration(border: Border.all(color: Colors.deepPurple[100])),
    child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Row(children: <Widget>[boldText("Author:"), Text(pull.author)]),
            Row(children: <Widget>[boldText("Date:"), Text(pull.date)])
          ],
        )));

Text boldText(String text) =>
    Text(text, style: TextStyle(fontWeight: FontWeight.bold));
