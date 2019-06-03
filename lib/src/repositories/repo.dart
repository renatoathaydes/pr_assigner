import '../util/data.dart';

mixin Repository {
  Future<List<PullRequest>> fetchPullRequests();
}
