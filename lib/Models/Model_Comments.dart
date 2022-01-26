


// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

// ignore_for_file: file_names

import 'dart:convert';

List<Model_Comments> commentsFromJson(String str) => List<Model_Comments>.from(json.decode(str).map((x) => Model_Comments.fromJson(x)));

//String welcomeToJson(List<Welcome> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Model_Comments {
  Model_Comments({
    required this.postId,
    required this.id,
    required this.name,
    required this.email,
    required this.body,
  });

  int postId;
  int id;
  String name;
  String email;
  String body;

  factory Model_Comments.fromJson(Map<String, dynamic> json) => Model_Comments(
    postId: json["postId"],
    id: json["id"],
    name: json["name"],
    email: json["email"],
    body: json["body"],
  );

  Map<String, dynamic> toJson() => {
    "postId": postId,
    "id": id,
    "name": name,
    "email": email,
    "body": body,
  };
}
