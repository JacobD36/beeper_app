// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

List<User> userFromJson(String str) => List<User>.from(json.decode(str).map((x) => User.fromJson(x)));

String userToJson(List<User> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class User {
    User({
        this.id,
        this.dni,
        this.email,
        this.idProfile,
        this.status,
        this.name1,
        this.name2,
        this.lastName1,
        this.lastName2,
        this.password,
        this.birthDate,
        this.createAt,
        this.modifiedAt,
    });

    String id;
    String dni;
    String email;
    int idProfile;
    int status;
    String name1;
    String name2;
    String lastName1;
    String lastName2;
    String password;
    DateTime birthDate;
    DateTime createAt;
    DateTime modifiedAt;

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        dni: json["dni"],
        email: json["email"],
        idProfile: json["idProfile"],
        status: json["status"],
        name1: json["name1"],
        name2: json["name2"],
        lastName1: json["lastName1"],
        lastName2: json["lastName2"],
        password: json["password"],
        birthDate: DateTime.parse(json["birthDate"]),
        createAt: DateTime.parse(json["createAt"]),
        modifiedAt: DateTime.parse(json["modifiedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "dni": dni,
        "email": email,
        "idProfile": idProfile,
        "status": status,
        "name1": name1,
        "name2": name2,
        "lastName1": lastName1,
        "lastName2": lastName2,
        "password": password,
        "birthDate": birthDate.toIso8601String(),
        "createAt": createAt.toIso8601String(),
        "modifiedAt": modifiedAt.toIso8601String(),
    };
}
