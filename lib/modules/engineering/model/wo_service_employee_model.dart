import 'dart:convert';

class WoServiceEmployeeModel {
  WoServiceEmployeeModel({
    required this.id,
    this.serviceId,
    this.employeeId,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  String id;
  String? serviceId;
  String? employeeId;
  int? createdBy;
  int? updatedBy;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;

  factory WoServiceEmployeeModel.fromJson(String str) =>
      WoServiceEmployeeModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory WoServiceEmployeeModel.fromMap(Map<dynamic, dynamic> json) =>
      WoServiceEmployeeModel(
        id: json["id"],
        serviceId: json["service_id"],
        employeeId: json["employee_id"],
        createdBy: json["created_by"],
        updatedBy: json["updated_by"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        deletedAt: json["deleted_at"] == null ? null : json["deleted_at"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "service_id": serviceId,
        "employee_id": employeeId,
        "created_by": createdBy,
        "updated_by": updatedBy,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "deleted_at": deletedAt,
      };
}
