// To parse this JSON data, do
//
//     final watchLive = watchLiveFromJson(jsonString);

import 'dart:convert';

List<WatchLive> watchLiveFromJson(String str) => List<WatchLive>.from(json.decode(str).map((x) => WatchLive.fromJson(x)));

String watchLiveToJson(List<WatchLive> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class WatchLive {
  int id;
  String facebookVideoUrl;
  String title;
  String image;

  WatchLive({
    required this.id,
    required this.facebookVideoUrl,
    required this.title,
    required this.image,
  });

  factory WatchLive.fromJson(Map<String, dynamic> json) => WatchLive(
    id: json["id"],
    facebookVideoUrl: json["facebook_video_url"],
    title: json["title"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "facebook_video_url": facebookVideoUrl,
    "title": title,
    "image": image,
  };
}
