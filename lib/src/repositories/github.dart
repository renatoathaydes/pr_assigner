import 'dart:convert' as convert;

import 'package:http/http.dart' as http;

import '../util/data.dart';
import 'repo.dart' as repo;

const githubAccept = 'application/vnd.github.v3+json';

class GitHubRepo implements repo.Repository {
  final String owner;
  final String project;

  GitHubRepo(this.owner, this.project);

  @override
  Future<List<PullRequest>> fetchPullRequests() => fetchGitHubData(
      Uri.parse("https://api.github.com/repos/$owner/$project/pulls"));
}

Future<List<PullRequest>> fetchGitHubData(Uri uri) async {
  final response = await http.get(uri, headers: {'Accept': githubAccept});
  if (response.statusCode == 200) {
    return (convert.jsonDecode(response.body) as List)
        .map((json) => PullRequest.fromJson(json))
        .toList(growable: false);
  }
  throw "Unexpected response from the server: $response";
}
