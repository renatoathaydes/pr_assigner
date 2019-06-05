import 'package:flutter_web/material.dart';
import 'package:pr_assigner/src/repositories/github.dart';

import 'repo_form.dart';

enum _RepositoryType { github, bitBucket }

class RepoSelector extends StatefulWidget {
  RepoSelector({Key key}) : super(key: key);

  @override
  RepoSelectorState createState() => RepoSelectorState();
}

class RepoSelectorState extends State<RepoSelector> {
  _RepositoryType _repoType;
  int _selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PR Assigner"),
      ),
      body: SingleChildScrollView(
        child: ExpansionPanelList(
          expansionCallback: (index, isExpanded) {
            if (index == _selectedIndex) {
              // hide current selection
              setState(() {
                _repoType = null;
                _selectedIndex = -1;
              });
            } else {
              setState(() {
                _repoType = _RepositoryType.values[index];
                _selectedIndex = index;
              });
            }
          },
          children: [
            ExpansionPanel(
                isExpanded: _repoType == _RepositoryType.github,
                headerBuilder: (context, isExpanded) {
                  return Center(child: Text("GitHub"));
                },
                body: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: RepoForm(GitHubRepo()),
                )),
            ExpansionPanel(
                isExpanded: _repoType == _RepositoryType.bitBucket,
                headerBuilder: (context, isExpanded) {
                  return Center(child: Text("BitBucket"));
                },
                // TODO
                body: Text("BitBucket BODY")),
          ],
        ),
      ),
    );
  }
}
