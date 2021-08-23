import 'dart:convert';

String commentPageToJson(List<CommentPage> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CommentPage {
  int? postId;
  int? id;
  String? name;
  String? email;
  String? body;

  CommentPage(this.postId, this.id, this.name, this.email, this.body);

  CommentPage.fromJson(Map<String, dynamic> json) {
    postId = json["postId"];
    id = json["id"];
    name = json["name"];
    email = json["email"];
    body = json["body"];
  }

  Map<String, dynamic> toJson() => {
        "postId": postId,
        "id": id,
        "name": name,
        "email": email,
        "body": body,
      };
}
