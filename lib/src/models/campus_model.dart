// To parse this JSON data, do
//
//     final campus = campusFromJson(jsonString);

import 'dart:convert';

List<Campus> campusFromJson(String str) => List<Campus>.from(json.decode(str).map((x) => Campus.fromJson(x)));

String campusToJson(List<Campus> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Campus {
    Campus({
        this.id,
        this.title,
        this.address,
        this.status,
        this.createAt,
        this.modifiedAt,
    });

    String id;
    String title;
    String address;
    int status;
    DateTime createAt;
    DateTime modifiedAt;

    factory Campus.fromJson(Map<String, dynamic> json) => Campus(
        id: json["id"],
        title: json["title"],
        address: json["address"],
        status: json["status"],
        createAt: DateTime.parse(json["createAt"]),
        modifiedAt: DateTime.parse(json["modifiedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "address": address,
        "status": status,
        "createAt": createAt.toIso8601String(),
        "modifiedAt": modifiedAt.toIso8601String(),
    };
}
