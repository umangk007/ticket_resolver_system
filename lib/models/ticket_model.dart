// To parse this JSON data, do
//
//     final ticketModel = ticketModelFromJson(jsonString);

import 'dart:convert';

TicketModel ticketModelFromJson(String str) => TicketModel.fromJson(json.decode(str));

String ticketModelToJson(TicketModel data) => json.encode(data.toJson());

class TicketModel {
  int? count;
  dynamic next;
  dynamic previous;
  List<Result>? results;

  TicketModel({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  factory TicketModel.fromJson(Map<String, dynamic> json) => TicketModel(
    count: json["count"],
    next: json["next"],
    previous: json["previous"],
    results: json["results"] == null ? [] : List<Result>.from(json["results"]!.map((x) => Result.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "count": count,
    "next": next,
    "previous": previous,
    "results": results == null ? [] : List<dynamic>.from(results!.map((x) => x.toJson())),
  };
}

class Result {
  int? id;
  Party? party;
  Complain? complain;
  Allocator? engineer;
  Allocator? callRecivedBy;
  Allocator? allocator;
  dynamic customComplain;
  DateTime? time;
  DateTime? createdOn;
  String? status;
  int? partyId;
  int? complainId;
  int? engineerId;
  int? callReciverId;
  int? allocatorId;

  Result({
    this.id,
    this.party,
    this.complain,
    this.engineer,
    this.callRecivedBy,
    this.allocator,
    this.customComplain,
    this.time,
    this.createdOn,
    this.status,
    this.partyId,
    this.complainId,
    this.engineerId,
    this.callReciverId,
    this.allocatorId,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"],
    party: json["party"] == null ? null : Party.fromJson(json["party"]),
    complain: json["complain"] == null ? null : Complain.fromJson(json["complain"]),
    engineer: json["engineer"] == null ? null : Allocator.fromJson(json["engineer"]),
    callRecivedBy: json["call_recived_by"] == null ? null : Allocator.fromJson(json["call_recived_by"]),
    allocator: json["allocator"] == null ? null : Allocator.fromJson(json["allocator"]),
    customComplain: json["custom_complain"],
    time: json["time"] == null ? null : DateTime.parse(json["time"]),
    createdOn: json["created_on"] == null ? null : DateTime.parse(json["created_on"]),
    status: json["status"],
    partyId: json["party_id"],
    complainId: json["complain_id"],
    engineerId: json["engineer_id"],
    callReciverId: json["call_reciver_id"],
    allocatorId: json["allocator_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "party": party?.toJson(),
    "complain": complain?.toJson(),
    "engineer": engineer?.toJson(),
    "call_recived_by": callRecivedBy?.toJson(),
    "allocator": allocator?.toJson(),
    "custom_complain": customComplain,
    "time": time?.toIso8601String(),
    "created_on": createdOn?.toIso8601String(),
    "status": status,
    "party_id": partyId,
    "complain_id": complainId,
    "engineer_id": engineerId,
    "call_reciver_id": callReciverId,
    "allocator_id": allocatorId,
  };
}

class Allocator {
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
  String? profilePic;
  String? address;
  String? city;
  String? state;
  String? typeOfUser;
  bool? isFirst;
  String? password2;
  String? password;
  bool? isWorking;
  bool? isAllocated;
  List<dynamic>? groups;
  List<dynamic>? userPermissions;

  Allocator({
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
    this.isAllocated,
    this.groups,
    this.userPermissions,
  });

  factory Allocator.fromJson(Map<String, dynamic> json) => Allocator(
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
    isAllocated: json["is_allocated"],
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
    "is_allocated": isAllocated,
    "groups": groups == null ? [] : List<dynamic>.from(groups!.map((x) => x)),
    "user_permissions": userPermissions == null ? [] : List<dynamic>.from(userPermissions!.map((x) => x)),
  };
}

class Complain {
  int? id;
  String? complain;

  Complain({
    this.id,
    this.complain,
  });

  factory Complain.fromJson(Map<String, dynamic> json) => Complain(
    id: json["id"],
    complain: json["complain"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "complain": complain,
  };
}

class Party {
  int? id;
  Allocator? owner;
  String? name;
  String? email;
  String? mobileNo;
  String? address;
  String? city;
  String? state;
  DateTime? createdOn;
  dynamic logo;
  int? ownerId;

  Party({
    this.id,
    this.owner,
    this.name,
    this.email,
    this.mobileNo,
    this.address,
    this.city,
    this.state,
    this.createdOn,
    this.logo,
    this.ownerId,
  });

  factory Party.fromJson(Map<String, dynamic> json) => Party(
    id: json["id"],
    owner: json["owner"] == null ? null : Allocator.fromJson(json["owner"]),
    name: json["name"],
    email: json["email"],
    mobileNo: json["mobile_no"],
    address: json["address"],
    city: json["city"],
    state: json["state"],
    createdOn: json["created_on"] == null ? null : DateTime.parse(json["created_on"]),
    logo: json["logo"],
    ownerId: json["owner_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "owner": owner?.toJson(),
    "name": name,
    "email": email,
    "mobile_no": mobileNo,
    "address": address,
    "city": city,
    "state": state,
    "created_on": createdOn?.toIso8601String(),
    "logo": logo,
    "owner_id": ownerId,
  };
}

