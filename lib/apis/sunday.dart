// To parse this JSON data, do
//
//     final sundayReply = sundayReplyFromJson(jsonString);

import 'dart:convert';

List<SundayReply> sundayReplyFromJson(String str) => List<SundayReply>.from(json.decode(str).map((x) => SundayReply.fromJson(x)));

String sundayReplyToJson(List<SundayReply> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SundayReply {
  int id;
  String title;
  String duration;
  String description;
  String videoUrl;
  String image;

  SundayReply({
    required this.id,
    required this.title,
    required this.duration,
    required this.description,
    required this.videoUrl,
    required this.image,
  });

  factory SundayReply.fromJson(Map<String, dynamic> json) => SundayReply(
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
