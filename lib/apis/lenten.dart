// To parse this JSON data, do
//
//     final lentenReply = lentenReplyFromJson(jsonString);

import 'dart:convert';

List<LentenReply> lentenReplyFromJson(String str) => List<LentenReply>.from(json.decode(str).map((x) => LentenReply.fromJson(x)));

String lentenReplyToJson(List<LentenReply> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LentenReply {
  int id;
  String title;
  String duration;
  String description;
  String videoUrl;
  String image;

  LentenReply({
    required this.id,
    required this.title,
    required this.duration,
    required this.description,
    required this.videoUrl,
    required this.image,
  });

  factory LentenReply.fromJson(Map<String, dynamic> json) => LentenReply(
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
