// To parse this JSON data, do
//
//     final profileModel = profileModelFromJson(jsonString);

import 'dart:convert';

ProfileModel profileModelFromJson(String str) => ProfileModel.fromJson(json.decode(str));

String profileModelToJson(ProfileModel data) => json.encode(data.toJson());

class ProfileModel {
  int? id;
  DateTime? lastLogin;
  bool? isSuperuser;
  String? firstName;
  String? lastName;
  String? email;
  bool? isStaff;
  bool? isActive;
  DateTime? dateJoined;
  String? username;
  String? mobileNo;
  dynamic profilePic;
  String? address;
  String? city;
  String? state;
  String? typeOfUser;
  bool? isFirst;
  String? password2;
  String? password;
  bool? isWorking;
  List<dynamic>? groups;
  List<dynamic>? userPermissions;

  ProfileModel({
    this.id,
    this.lastLogin,
    this.isSuperuser,
    this.firstName,
    this.lastName,
    this.email,
    this.isStaff,
    this.isActive,
    this.dateJoined,
    this.username,
    this.mobileNo,
    this.profilePic,
    this.address,
    this.city,
    this.state,
    this.typeOfUser,
    this.isFirst,
    this.password2,
    this.password,
    this.isWorking,
    this.groups,
    this.userPermissions,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
    id: json["id"],
    lastLogin: json["last_login"] == null ? null : DateTime.parse(json["last_login"]),
    isSuperuser: json["is_superuser"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    email: json["email"],
    isStaff: json["is_staff"],
    isActive: json["is_active"],
    dateJoined: json["date_joined"] == null ? null : DateTime.parse(json["date_joined"]),
    username: json["username"],
    mobileNo: json["mobile_no"],
    profilePic: json["profile_pic"],
    address: json["address"],
    city: json["city"],
    state: json["state"],
    typeOfUser: json["type_of_user"],
    isFirst: json["is_first"],
    password2: json["password2"],
    password: json["password"],
    isWorking: json["is_working"],
    groups: json["groups"] == null ? [] : List<dynamic>.from(json["groups"]!.map((x) => x)),
    userPermissions: json["user_permissions"] == null ? [] : List<dynamic>.from(json["user_permissions"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "last_login": lastLogin?.toIso8601String(),
    "is_superuser": isSuperuser,
    "first_name": firstName,
    "last_name": lastName,
    "email": email,
    "is_staff": isStaff,
    "is_active": isActive,
    "date_joined": dateJoined?.toIso8601String(),
    "username": username,
    "mobile_no": mobileNo,
    "profile_pic": profilePic,
    "address": address,
    "city": city,
    "state": state,
    "type_of_user": typeOfUser,
    "is_first": isFirst,
    "password2": password2,
    "password": password,
    "is_working": isWorking,
    "groups": groups == null ? [] : List<dynamic>.from(groups!.map((x) => x)),
    "user_permissions": userPermissions == null ? [] : List<dynamic>.from(userPermissions!.map((x) => x)),
  };
}
