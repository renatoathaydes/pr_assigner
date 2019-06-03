import 'dart:convert' as convert;

import 'package:flutter_web/material.dart';
import '../data.dart';

import '../util/data.dart';
import '../util/ui.dart';
import '../views/pull_requests.dart';

final repository = Repository();

class RepoSelector extends StatefulWidget {
  RepoSelector({Key key}) : super(key: key);

  @override
  RepoSelectorState createState() => RepoSelectorState();
}

class RepoSelectorState extends State<RepoSelector> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PR Assigner"),
      ),
      body: Column(children: <Widget>[
        Expanded(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: RepositoryForm(),
        )),
      ]),
    );
  }
}

class RepositoryForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: RepoForm());
  }
}

class RepoForm extends StatefulWidget {
  @override
  RepoFormState createState() {
    return RepoFormState();
  }
}

const String success = null;

class RepoFormState extends State<RepoForm> {
  final _formKey = GlobalKey<FormState>();
  Uri _uri;
  bool _loading = false;

  String _validateUri(String value) {
    if (value.trim().isEmpty) {
      return 'Please enter a Git repository URL';
    }
    _uri = Uri.tryParse(value);
    if (_uri == null) {
      return 'Invalid URL';
    }
    return success;
  }

  void _onSubmit() async {
    if (_loading) {
      return;
    }

    if (_formKey.currentState.validate()) {
      setState(() {
        _loading = true;
      });

      Scaffold.of(context).showSnackBar(SnackBar(
          duration: Duration(minutes: 5),
          content: fetchingDataSnackBarContent()));

      try {
        final body = getData();
//        final pullRequests = await fetchGitHubData(_uri);
        final json = convert.jsonDecode(body) as List;
        final pullRequests =
            json.map((pr) => PullRequest.fromJson(pr)).toList();
        await Navigator.of(context).push(FadeRouteBuilder(
            page: PullRequests(
                key: ValueKey(_uri),
                title: "$_uri",
                pullRequests: pullRequests)));
      } finally {
        Scaffold.of(context).hideCurrentSnackBar();
        setState(() {
          _loading = false;
        });
      }
    }
  }

  Widget fetchingDataSnackBarContent() {
    return Text('Fetching data');
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey we created above
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("Enter a GitHub Repository URL:",
              style: const TextStyle(fontSize: 18)),
          TextFormField(validator: _validateUri),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: RaisedButton(
              textColor: _loading ? Colors.red : Colors.black,
              onPressed: _onSubmit,
              child: Text('Fetch Pull Requests'),
            ),
          ),
        ],
      ),
    );
  }
}
