import 'package:flutter_web/material.dart';
import 'package:pr_assigner/src/repositories/repo.dart';

import '../util/ui.dart';
import '../views/pull_requests.dart';

class RepoForm extends StatefulWidget {
  final Repository _repository;

  RepoForm(this._repository);

  @override
  RepoFormState createState() {
    return RepoFormState();
  }
}

const String _success = null;

class RepoFormState extends State<RepoForm> {
  final _formKey = GlobalKey<FormState>();
  final _ownerController = TextEditingController();
  final _repoNameController = TextEditingController();
  bool _loading = false;

  String _validateNotEmpty(String value) {
    if (value.trim().isEmpty) {
      return 'Please enter a value';
    }
    return _success;
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
        final pullRequests = await widget._repository
            .fetchPullRequests(_ownerController.text, _repoNameController.text);

        await Navigator.of(context).push(FadeRouteBuilder(
            page: PullRequests(
                key: ValueKey(_ownerController.text + _repoNameController.text),
                title: _repoNameController.text,
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
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("Repository owner:", style: const TextStyle(fontSize: 18)),
          TextFormField(
            validator: _validateNotEmpty,
            controller: _ownerController,
          ),
          SizedBox(height: 20),
          Text("Repository name:", style: const TextStyle(fontSize: 18)),
          TextFormField(
            validator: _validateNotEmpty,
            controller: _repoNameController,
          ),
          SizedBox(height: 20),
          RaisedButton(
            textColor: _loading ? Colors.red : Colors.black,
            onPressed: _onSubmit,
            child: Text('Fetch Pull Requests'),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
