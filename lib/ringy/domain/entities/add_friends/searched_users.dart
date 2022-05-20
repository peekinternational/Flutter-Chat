// To parse this JSON data, do
//
//     final searchedUsers = searchedUsersFromJson(jsonString);

import 'dart:convert';

SearchedUsers searchedUsersFromJson(String str) => SearchedUsers.fromJson(json.decode(str));

String searchedUsersToJson(SearchedUsers data) => json.encode(data.toJson());

class SearchedUsers {
  SearchedUsers({
    required this.status,
    required this.name,
  });

  int status;
  List<Datum> name;

  factory SearchedUsers.fromJson(Map<String, dynamic> json) => SearchedUsers(
    status: json["status"],
    name: List<Datum>.from(json["Datum"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "Datum": List<dynamic>.from(name.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    required this.id,
    required this.name,
    required this.userImage,
    required this.friendStatus,
  });

  String id;
  String name;
  String userImage;
  int friendStatus;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["_id"],
    name: json["name"],
    userImage: json["user_image"],
    friendStatus: json["friendStatus"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "user_image": userImage,
    "friendStatus": friendStatus,
  };
}
