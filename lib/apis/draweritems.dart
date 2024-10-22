// To parse this JSON data, do
//
//     final drawerItems = drawerItemsFromJson(jsonString);

import 'dart:convert';

DrawerItems drawerItemsFromJson(String str) => DrawerItems.fromJson(json.decode(str));

String drawerItemsToJson(DrawerItems data) => json.encode(data.toJson());

class DrawerItems {
  List<Link> links;

  DrawerItems({
    required this.links,
  });

  factory DrawerItems.fromJson(Map<String, dynamic> json) => DrawerItems(
    links: List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "links": List<dynamic>.from(links.map((x) => x.toJson())),
  };
}

class Link {
  String title;
  String url;

  Link({
    required this.title,
    required this.url,
  });

  factory Link.fromJson(Map<String, dynamic> json) => Link(
    title: json["title"],
    url: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "url": url,
  };
}
