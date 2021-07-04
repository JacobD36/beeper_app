// To parse this JSON data, do
//
//     final campaign = campaignFromJson(jsonString);

import 'dart:convert';

List<Campaign> campaignFromJson(String str) => List<Campaign>.from(json.decode(str).map((x) => Campaign.fromJson(x)));

String campaignToJson(List<Campaign> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Campaign {
    Campaign({
        this.id,
        this.title,
        this.desc,
        this.status,
        this.responsable,
        this.phone,
        this.createAt,
        this.modifiedAt,
    });

    String id;
    String title;
    String desc;
    int status;
    String responsable;
    String phone;
    DateTime createAt;
    DateTime modifiedAt;

    factory Campaign.fromJson(Map<String, dynamic> json) => Campaign(
        id: json["id"],
        title: json["title"],
        desc: json["desc"],
        status: json["status"],
        responsable: json["responsable"],
        phone: json["phone"],
        createAt: DateTime.parse(json["createAt"]),
        modifiedAt: DateTime.parse(json["modifiedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "desc": desc,
        "status": status,
        "responsable": responsable,
        "phone": phone,
        "createAt": createAt.toIso8601String(),
        "modifiedAt": modifiedAt.toIso8601String(),
    };
}
