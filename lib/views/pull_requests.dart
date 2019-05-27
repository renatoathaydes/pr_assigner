import 'dart:convert' as convert;

import 'package:flutter_web/material.dart';
import 'package:flutter_web/widgets.dart';
import 'package:pr_assigner/data.dart';
import 'package:pr_assigner/views/selector.dart';

const githubAccept = 'application/vnd.github.v3+json';

class PullRequests extends StatefulWidget {
  PullRequests({Key key, this.title}) : super(key: key);

  final String title;

  @override
  PullRequestsState createState() => PullRequestsState();
}

class PullRequestsState extends State<PullRequests> {
  String errorMessage;
  List<PullRequest> pullRequests = [];
  int timeToGet = 0;

  @override
  void initState() {
    super.initState();
    load();
  }

  void load() async {
    final startTime = DateTime.now();
//    final response = await http
//        .get('https://api.github.com/repos/flutter/flutter/pulls', headers: {
//      'Accept': githubAccept,
//    });
//
//    final body = response.body;
    dynamic response = SimulatedResponse();
    response.statusCode = 200;
    final body = getData();

    final totalTime = DateTime.now().millisecondsSinceEpoch -
        startTime.millisecondsSinceEpoch;

    if (response.statusCode == 200) {
      final json = convert.jsonDecode(body) as List;
      final pulls = json.map((p) => PullRequest(p)).toList(growable: false);

      setState(() {
        this.errorMessage = null;
        this.pullRequests = pulls;
        this.timeToGet = totalTime;
      });
    } else {
      setState(() {
        this.errorMessage =
            "Unexpected response status code: ${response.statusCode}";
        this.pullRequests = const [];
        this.timeToGet = totalTime;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Pull Requests Viewer"),
        ),
        body: Column(
          children: <Widget>[
            Selector(),
            Container(
                alignment: AlignmentDirectional.topStart,
                padding: const EdgeInsets.all(25.0),
                child: Text(
                    "There are currently ${pullRequests.length} pull requests",
                    style:
                        TextStyle(fontStyle: FontStyle.italic, fontSize: 18))),
            Expanded(
                child: ListView(
              padding: const EdgeInsets.all(20.0),
              children: pullRequests.map(pullRequestWidget).toList(),
            )),
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
}

Text boldText(String text) =>
    Text(text, style: TextStyle(fontWeight: FontWeight.bold));

class SimulatedResponse {
  int statusCode = 200;
}

class PullRequest {
  final String title;
  final String author;
  final String date;
  final Uri uri;

  PullRequest(json)
      : title = json["title"],
        author = json["user"]["login"],
        date = json["created_at"],
        uri = Uri.parse(json["url"]);
}
