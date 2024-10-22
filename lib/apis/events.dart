// To parse this JSON data, do
//
//     final events = eventsFromJson(jsonString);

import 'dart:convert';

List<Events> eventsFromJson(String str) => List<Events>.from(json.decode(str).map((x) => Events.fromJson(x)));

String eventsToJson(List<Events> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Events {
  int id;
  String title;
  String subtitle;
  String shortDate;
  String shortMonth;
  String fullDate;
  String time;
  String address;
  String phone;
  String fax;
  String email;
  String image;

  Events({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.shortDate,
    required this.shortMonth,
    required this.fullDate,
    required this.time,
    required this.address,
    required this.phone,
    required this.fax,
    required this.email,
    required this.image,
  });

  factory Events.fromJson(Map<String, dynamic> json) => Events(
    id: json["id"],
    title: json["title"],
    subtitle: json["subtitle"],
    shortDate: json["short_date"],
    shortMonth: json["short_month"],
    fullDate: json["full_date"],
    time: json["time"],
    address: json["address"],
    phone: json["phone"],
    fax: json["fax"],
    email: json["email"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "subtitle": subtitle,
    "short_date": shortDate,
    "short_month": shortMonth,
    "full_date": fullDate,
    "time": time,
    "address": address,
    "phone": phone,
    "fax": fax,
    "email": email,
    "image": image,
  };
}
