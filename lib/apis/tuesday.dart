// To parse this JSON data, do
//
//     final tuesdayReply = tuesdayReplyFromJson(jsonString);

import 'dart:convert';

List<TuesdayReply> tuesdayReplyFromJson(String str) => List<TuesdayReply>.from(json.decode(str).map((x) => TuesdayReply.fromJson(x)));

String tuesdayReplyToJson(List<TuesdayReply> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TuesdayReply {
  int id;
  String title;
  String duration;
  String description;
  String videoUrl;
  String image;

  TuesdayReply({
    required this.id,
    required this.title,
    required this.duration,
    required this.description,
    required this.videoUrl,
    required this.image,
  });

  factory TuesdayReply.fromJson(Map<String, dynamic> json) => TuesdayReply(
    id: json["id"],
    title: json["title"],
    duration: json["duration"],
    description: json["description"],
    videoUrl: json["video_url"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "duration": duration,
    "description": description,
    "video_url": videoUrl,
    "image": image,
  };
}
