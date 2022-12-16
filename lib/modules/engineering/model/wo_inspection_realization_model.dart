// To parse this JSON data, do
//
//     final woInspectionRealizationModel = woInspectionRealizationModelFromMap(jsonString);

import 'dart:convert';

class WoInspectionRealizationModel {
  WoInspectionRealizationModel({
    this.id,
    this.inspectionId,
    this.employeeId,
    this.startAt,
    this.finishAt,
    this.code,
    this.machineCode,
    this.activityCode,
    this.duration,
    this.effectivity,
    this.pointEffectivity,
    this.point,
    this.description,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.workType,
  });

  String? id;
  String? inspectionId;
  String? employeeId;
  String? startAt;
  String? finishAt;
  String? code;
  String? machineCode;
  String? activityCode;
  int? duration;
  double? effectivity;
  double? pointEffectivity;
  double? point;
  String? description;
  int? createdBy;
  int? updatedBy;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  String? workType;

  factory WoInspectionRealizationModel.fromJson(String str) =>
      WoInspectionRealizationModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory WoInspectionRealizationModel.fromMap(Map<dynamic, dynamic> json) =>
      WoInspectionRealizationModel(
        id: json["id"],
        inspectionId: json["inspection_id"],
        employeeId: json["employee_id"],
        startAt: json["start_at"],
        finishAt: json["finish_at"],
        code: json["code"],
        activityCode: json["activity_code"],
        machineCode: json["machine_code"],
        duration: json["duration"],
        effectivity: json["effectivity"].toDouble(),
        pointEffectivity: json["point_effectivity"].toDouble(),
        point: json["point"].toDouble(),
        description: json["description"],
        createdBy: json["created_by"],
        updatedBy: json["updated_by"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        deletedAt: json["deleted_at"] == null ? null : json["deleted_at"],
        workType: json["work_type"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "inspection_id": inspectionId,
        "employee_id": employeeId,
        "start_at": startAt,
        "finish_at": finishAt,
        "code": code,
        "machine_code": machineCode,
        "activity_code": activityCode,
        "duration": duration,
        "effectivity": effectivity,
        "point_effectivity": pointEffectivity,
        "point": point,
        "description": description,
        "created_by": createdBy,
        "updated_by": updatedBy,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "deleted_at": deletedAt,
        "work_type": workType,
      };
}
