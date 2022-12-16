// To parse this JSON data, do
//
//     final woProjectRealizationModel = woProjectRealizationModelFromMap(jsonString);

import 'dart:convert';

class WoProjectRealizationModel {
  WoProjectRealizationModel({
    this.id,
    this.projectDetailId,
    this.employeeId,
    this.executedAt,
    this.startAt,
    this.finishAt,
    this.code,
    this.machineCode,
    this.activityCode,
    this.duration,
    this.effectivity,
    this.pointEffectivity,
    this.point,
    this.progress,
    this.description,
    this.isActive,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.workType,
  });

  String? id;
  String? projectDetailId;
  String? employeeId;
  String? executedAt;
  String? startAt;
  String? finishAt;
  String? code;
  String? machineCode;
  String? activityCode;
  int? duration;
  double? effectivity;
  double? pointEffectivity;
  double? point;
  int? progress;
  String? description;
  int? isActive;
  int? createdBy;
  int? updatedBy;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  String? workType;

  factory WoProjectRealizationModel.fromJson(String str) =>
      WoProjectRealizationModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory WoProjectRealizationModel.fromMap(Map<dynamic, dynamic> json) =>
      WoProjectRealizationModel(
        id: json["id"],
        projectDetailId: json["project_detail_id"],
        employeeId: json["employee_id"],
        executedAt: json["executed_at"],
        startAt: json["start_at"],
        finishAt: json["finish_at"],
        code: json["code"],
        activityCode: json["activity_code"],
        machineCode: json["machine_code"],
        duration: json["duration"],
        effectivity: json["effectivity"],
        pointEffectivity: json["point_effectivity"],
        point: json["point"].toDouble(),
        progress: json["progress"],
        description: json["description"],
        isActive: json["is_active"],
        createdBy: json["created_by"],
        updatedBy: json["updated_by"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        deletedAt: json["deleted_at"] == null ? null : json["deleted_at"],
        workType: json["work_type"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "project_detail_id": projectDetailId,
        "employee_id": employeeId,
        "executed_at": executedAt,
        "start_at": startAt,
        "finish_at": finishAt,
        "code": code,
        "machine_code": machineCode,
        "activity_code": activityCode,
        "duration": duration,
        "effectivity": effectivity,
        "point_effectivity": pointEffectivity,
        "point": point,
        "progress": progress,
        "description": description,
        "is_active": isActive,
        "created_by": createdBy,
        "updated_by": updatedBy,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "deleted_at": deletedAt,
        "work_type": workType,
      };
}
