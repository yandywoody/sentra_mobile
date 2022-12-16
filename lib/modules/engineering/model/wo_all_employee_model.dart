import 'dart:convert';

class WoAllEmployeeModel {
  WoAllEmployeeModel({
    this.id,
    this.woId,
    this.employeeId,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  String? id;
  String? woId;
  String? employeeId;
  int? createdBy;
  int? updatedBy;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;

  factory WoAllEmployeeModel.fromJson(String str) =>
      WoAllEmployeeModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory WoAllEmployeeModel.fromMap(Map<dynamic, dynamic> json) =>
      WoAllEmployeeModel(
        id: json["id"],
        woId: json["wo_id"],
        employeeId: json["employee_id"],
        createdBy: json["created_by"],
        updatedBy: json["updated_by"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        deletedAt: json["deleted_at"] == null ? null : json["deleted_at"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "wo_id": woId,
        "employee_id": employeeId,
        "created_by": createdBy,
        "updated_by": updatedBy,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "deleted_at": deletedAt,
      };
}
