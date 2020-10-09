import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
    UserModel({
        this.name,
        this.uid,
        this.username,
    });

    String name;
    String uid;
    String username;

    factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        name: json["name"],
        uid: json["uid"],
        username: json["username"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "uid": uid,
        "username": username,
    };
}
