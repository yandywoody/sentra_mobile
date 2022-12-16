import 'dart:convert';

class WoServiceRealizationModel {
  WoServiceRealizationModel({
    this.id,
    this.serviceId,
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
    this.isFinish,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.workType,
  });

  String? id;
  String? serviceId;
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
  int? isFinish;
  int? createdBy;
  int? updatedBy;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  String? workType;

  factory WoServiceRealizationModel.fromJson(String str) =>
      WoServiceRealizationModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory WoServiceRealizationModel.fromMap(Map<dynamic, dynamic> json) =>
      WoServiceRealizationModel(
        id: json["id"],
        serviceId: json["service_id"],
        employeeId: json["employee_id"],
        startAt: json["start_at"],
        finishAt: json["finish_at"],
        code: json["code"],
        activityCode: json["activity_code"],
        machineCode: json["machine_code"],
        duration: json["duration"],
        effectivity: json["effectivity"],
        pointEffectivity: json["point_effectivity"],
        point: json["point"].toDouble(),
        description: json["description"],
        isFinish: json["is_finish"],
        createdBy: json["created_by"],
        updatedBy: json["updated_by"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        deletedAt: json["deleted_at"] == null ? null : json["deleted_at"],
        workType: json["work_type"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "service_id": serviceId,
        "employee_id": employeeId,
        "start_at": startAt,
        "finish_at": finishAt,
        "duration": duration,
        "code": code,
        "machine_code": machineCode,
        "activity_code": activityCode,
        "effectivity": effectivity,
        "point_effectivity": pointEffectivity,
        "point": point,
        "description": description,
        "is_finish": isFinish,
        "created_by": createdBy,
        "updated_by": updatedBy,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "deleted_at": deletedAt,
        "work_type": workType,
      };
}
