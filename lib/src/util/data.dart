import 'package:meta/meta.dart' show immutable;

@immutable
class PullRequest {
  final String title;
  final String author;
  final String date;
  final Uri uri;

  PullRequest.fromJson(json)
      : title = json["title"],
        author = json["user"]["login"],
        date = json["created_at"],
        uri = Uri.parse(json["url"]);
}

@immutable
class Repository {
  final Uri uri;

  Repository([this.uri]);
}
