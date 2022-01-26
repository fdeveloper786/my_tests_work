

// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

// ignore_for_file: file_names, camel_case_types

import 'dart:convert';

List<Model_Photo> photoFromJson(String str) => List<Model_Photo>.from(json.decode(str).map((x) => Model_Photo.fromJson(x)));

//String welcomeToJson(List<Model_Photo> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));



class Model_Photo {
  Model_Photo({
    required this.albumId,
    required this.id,
    required this.title,
    required this.url,
    required this.thumbnailUrl,
  });

  int albumId;
  int id;
  String title;
  String url;
  String thumbnailUrl;

  factory Model_Photo.fromJson(Map<String, dynamic> parsedJson) => Model_Photo(
    albumId: parsedJson["albumId"],
    id: parsedJson["id"],
    title: parsedJson["title"],
    url: parsedJson["url"],
    thumbnailUrl: parsedJson["thumbnailUrl"],
  );

  Map<String, dynamic> toJson() => {
    "albumId": albumId,
    "id": id,
    "title": title,
    "url": url,
    "thumbnailUrl": thumbnailUrl,
  };
}
