import 'dart:convert';

class WoRepairEmployeeModel {
  WoRepairEmployeeModel({
    required this.id,
    this.repairId,
    this.employeeId,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  String id;
  String? repairId;
  String? employeeId;
  int? createdBy;
  int? updatedBy;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;

  factory WoRepairEmployeeModel.fromJson(String str) =>
      WoRepairEmployeeModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory WoRepairEmployeeModel.fromMap(Map<dynamic, dynamic> json) =>
      WoRepairEmployeeModel(
        id: json["id"],
        repairId: json["repair_id"],
        employeeId: json["employee_id"],
        createdBy: json["created_by"],
        updatedBy: json["updated_by"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        deletedAt: json["deleted_at"] == null ? null : json["deleted_at"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "repair_id": repairId,
        "employee_id": employeeId,
        "created_by": createdBy,
        "updated_by": updatedBy,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "deleted_at": deletedAt,
      };
}
