import 'dart:convert';

class RealizationModel {
  RealizationModel({
    this.id,
    this.serviceId,
    this.employeeId,
    this.startAt,
    this.finishAt,
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
  });

  String? id;
  String? serviceId;
  String? employeeId;
  String? startAt;
  String? finishAt;
  int? duration;
  num? effectivity;
  num? pointEffectivity;
  num? point;
  String? description;
  int? isFinish;
  int? createdBy;
  int? updatedBy;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;

  factory RealizationModel.fromJson(String str) =>
      RealizationModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory RealizationModel.fromMap(Map<dynamic, dynamic> json) =>
      RealizationModel(
        id: json["id"] == null ? null : json["id"],
        serviceId: json["service_id"] == null ? null : json["service_id"],
        employeeId: json["employee_id"] == null ? null : json["employee_id"],
        startAt: json["start_at"] == null ? null : json["start_at"],
        finishAt: json["finish_at"] == null ? null : json["finish_at"],
        duration: json["duration"] == null ? null : json["duration"],
        effectivity: json["effectivity"] == null ? null : json["effectivity"],
        pointEffectivity: json["point_effectivity"] == null
            ? null
            : json["point_effectivity"],
        point: json["point"] == null ? null : json["point"].toDouble(),
        description: json["description"],
        isFinish: json["is_finish"] == null ? null : json["is_finish"],
        createdBy: json["created_by"] == null ? null : json["created_by"],
        updatedBy: json["updated_by"] == null ? null : json["updated_by"],
        createdAt: json["created_at"] == null ? null : json["created_at"],
        updatedAt: json["updated_at"] == null ? null : json["updated_at"],
        deletedAt: json["deleted_at"],
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "service_id": serviceId == null ? null : serviceId,
        "employee_id": employeeId == null ? null : employeeId,
        "start_at": startAt == null ? null : startAt,
        "finish_at": finishAt == null ? null : finishAt,
        "duration": duration == null ? null : duration,
        "effectivity": effectivity == null ? null : effectivity,
        "point_effectivity": pointEffectivity == null ? null : pointEffectivity,
        "point": point == null ? null : point,
        "description": description,
        "is_finish": isFinish == null ? null : isFinish,
        "created_by": createdBy == null ? null : createdBy,
        "updated_by": updatedBy == null ? null : updatedBy,
        "created_at": createdAt == null ? null : createdAt,
        "updated_at": updatedAt == null ? null : updatedAt,
        "deleted_at": deletedAt,
      };
}
