// To parse this JSON data, do
//
//     final newBirthBreakThrough = newBirthBreakThroughFromJson(jsonString);

import 'dart:convert';

List<NewBirthBreakThrough> newBirthBreakThroughFromJson(String str) => List<NewBirthBreakThrough>.from(json.decode(str).map((x) => NewBirthBreakThrough.fromJson(x)));

String newBirthBreakThroughToJson(List<NewBirthBreakThrough> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class NewBirthBreakThrough {
  int id;
  String title;
  String date;
  String videoUrl;
  String image;
  String description;

  NewBirthBreakThrough({
    required this.id,
    required this.title,
    required this.date,
    required this.videoUrl,
    required this.image,
    required this.description,
  });

  factory NewBirthBreakThrough.fromJson(Map<String, dynamic> json) => NewBirthBreakThrough(
    id: json["id"],
    title: json["title"],
    date: json["date"],
    videoUrl: json["video_url"],
    image: json["image"],
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "date": date,
    "video_url": videoUrl,
    "image": image,
    "description": description,
  };
}
