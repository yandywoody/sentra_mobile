import 'dart:convert';

class UserModel {
  UserModel({
    this.id,
    this.employeeId,
    this.name,
    this.password,
    this.photo,
    this.rememberToken,
    this.apiToken,
    this.lastLoggedIp,
    this.lastLoggedAt,
    this.isActive,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  int? id;
  String? employeeId;
  String? name;
  String? password;
  String? photo;
  String? rememberToken;
  String? apiToken;
  String? lastLoggedIp;
  String? lastLoggedAt;
  int? isActive;
  int? createdBy;
  int? updatedBy;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;

  factory UserModel.fromJson(String str) => UserModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserModel.fromMap(Map<dynamic, dynamic> json) => UserModel(
        id: json["id"],
        employeeId: json["employee_id"],
        name: json["name"],
        password: json["password"],
        photo: json["photo"] == null ? "" : json["photo"],
        rememberToken:
            json["remember_token"] == null ? "" : json["remember_token"],
        apiToken: json["api_token"] == null ? "" : json["api_token"],
        lastLoggedIp:
            json["last_logged_ip"] == null ? "" : json["last_logged_ip"],
        lastLoggedAt:
            json["last_logged_at"] == null ? "" : json["last_logged_at"],
        isActive: json["is_active"],
        createdBy: json["created_by"],
        updatedBy: json["updated_by"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        deletedAt: json["deleted_at"] == null ? null : json["deleted_at"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "employee_id": employeeId,
        "name": name,
        "password": password,
        "photo": photo == null ? "" : photo,
        "remember_token": rememberToken == null ? "" : rememberToken,
        "api_token": apiToken == null ? null : apiToken,
        "last_logged_ip": lastLoggedIp == null ? "" : lastLoggedIp,
        "last_logged_at": lastLoggedAt == null ? "" : lastLoggedAt,
        "is_active": isActive,
        "created_by": createdBy,
        "updated_by": updatedBy,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "deleted_at": deletedAt == null ? null : deletedAt,
      };
}
