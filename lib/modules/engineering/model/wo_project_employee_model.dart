import 'dart:convert';

class WoProjectEmployeeModel {
  WoProjectEmployeeModel({
    required this.id,
    this.projectDetailCode,
    this.employeeId,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  String id;
  String? projectDetailCode;
  String? employeeId;
  int? createdBy;
  int? updatedBy;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;

  factory WoProjectEmployeeModel.fromJson(String str) =>
      WoProjectEmployeeModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory WoProjectEmployeeModel.fromMap(Map<dynamic, dynamic> json) =>
      WoProjectEmployeeModel(
        id: json["id"],
        projectDetailCode: json["project_detail_code"],
        employeeId: json["employee_id"],
        createdBy: json["created_by"],
        updatedBy: json["updated_by"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        deletedAt: json["deleted_at"] == null ? null : json["deleted_at"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "project_detail_code": projectDetailCode,
        "employee_id": employeeId,
        "created_by": createdBy,
        "updated_by": updatedBy,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "deleted_at": deletedAt,
      };
}
