// To parse this JSON data, do
//
//     final profile = profileFromJson(jsonString);

import 'dart:convert';

List<Profile> profileFromJson(String str) => List<Profile>.from(json.decode(str).map((x) => Profile.fromJson(x)));

String profileToJson(List<Profile> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Profile {
    Profile({
        this.id,
        this.title,
        this.createAt,
        this.modifiedAt,
    });

    String id;
    String title;
    DateTime createAt;
    DateTime modifiedAt;

    factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        id: json["id"],
        title: json["title"],
        createAt: DateTime.parse(json["createAt"]),
        modifiedAt: DateTime.parse(json["modifiedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "createAt": createAt.toIso8601String(),
        "modifiedAt": modifiedAt.toIso8601String(),
    };
}
