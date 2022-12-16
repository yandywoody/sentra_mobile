import 'dart:convert';

class WoInspectionEmployeeModel {
  WoInspectionEmployeeModel({
    required this.id,
    this.inspectionId,
    this.employeeId,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  String id;
  String? inspectionId;
  String? employeeId;
  int? createdBy;
  int? updatedBy;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;

  factory WoInspectionEmployeeModel.fromJson(String str) =>
      WoInspectionEmployeeModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory WoInspectionEmployeeModel.fromMap(Map<dynamic, dynamic> json) =>
      WoInspectionEmployeeModel(
        id: json["id"],
        inspectionId: json["inspection_id"],
        employeeId: json["employee_id"],
        createdBy: json["created_by"],
        updatedBy: json["updated_by"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        deletedAt: json["deleted_at"] == null ? null : json["deleted_at"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "inspection_id": inspectionId,
        "employee_id": employeeId,
        "created_by": createdBy,
        "updated_by": updatedBy,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "deleted_at": deletedAt,
      };
}
