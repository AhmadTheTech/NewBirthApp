// To parse this JSON data, do
//
//     final newBirthLinks = newBirthLinksFromJson(jsonString);

import 'dart:convert';

NewBirthLinks newBirthLinksFromJson(String str) => NewBirthLinks.fromJson(json.decode(str));

String newBirthLinksToJson(NewBirthLinks data) => json.encode(data.toJson());

class NewBirthLinks {
  String giveLink1;
  String giveLink2;
  String giveLink3;
  String bottomBarShopLink;
  String bottomBarBibleLink;
  String ourHistoryLink;
  String membershipButton1;
  String membershipButton2;
  String membershipButton3;

  NewBirthLinks({
    required this.giveLink1,
    required this.giveLink2,
    required this.giveLink3,
    required this.bottomBarShopLink,
    required this.bottomBarBibleLink,
    required this.ourHistoryLink,
    required this.membershipButton1,
    required this.membershipButton2,
    required this.membershipButton3,
  });

  factory NewBirthLinks.fromJson(Map<String, dynamic> json) => NewBirthLinks(
    giveLink1: json["give_link_1"],
    giveLink2: json["give_link_2"],
    giveLink3: json["give_link_3"],
    bottomBarShopLink: json["bottom_bar_shop_link"],
    bottomBarBibleLink: json["bottom_bar_bible_link"],
    ourHistoryLink: json["our_history_link"],
    membershipButton1: json["membership_button_1"],
    membershipButton2: json["membership_button_2"],
    membershipButton3: json["membership_button_3"],
  );

  Map<String, dynamic> toJson() => {
    "give_link_1": giveLink1,
    "give_link_2": giveLink2,
    "give_link_3": giveLink3,
    "bottom_bar_shop_link": bottomBarShopLink,
    "bottom_bar_bible_link": bottomBarBibleLink,
    "our_history_link": ourHistoryLink,
    "membership_button_1": membershipButton1,
    "membership_button_2": membershipButton2,
    "membership_button_3": membershipButton3,
  };
}
