import 'dart:convert';

class WoProjectModel {
  WoProjectModel({
    this.id,
    this.code,
    this.projectId,
    this.difficultyId,
    this.name,
    this.startAt,
    this.finishAt,
    this.activityCode,
    this.duration,
    this.durationRealization,
    this.score,
    this.point,
    this.note,
    this.executedAt,
    this.dates,
    this.isActive,
    this.isSuitable,
    this.isAdminNote,
    this.adminNote,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.workType,
  });

  String? id;
  String? code;
  String? projectId;
  String? difficultyId;
  String? name;
  String? activityCode;
  String? startAt;
  String? finishAt;
  int? duration;
  int? durationRealization;
  double? score;
  double? point;
  String? note;
  String? executedAt;
  String? dates;
  int? isActive;
  int? isSuitable;
  int? isAdminNote;
  String? adminNote;
  int? createdBy;
  int? updatedBy;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  String? workType;

  factory WoProjectModel.fromJson(String str) =>
      WoProjectModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory WoProjectModel.fromMap(Map<dynamic, dynamic> json) => WoProjectModel(
        id: json["id"],
        code: json["code"],
        projectId: json["project_id"],
        difficultyId: json["difficulty_id"],
        name: json["name"],
        startAt: json["start_at"],
        finishAt: json["finish_at"],
        activityCode: json["activity_code"],
        duration: json["duration"],
        durationRealization: json["duration_realization"],
        score: json["score"].toDouble(),
        point: json["point"].toDouble(),
        note: json["note"],
        executedAt: json["executed_at"],
        dates: json["dates"],
        isActive: json["is_active"],
        isSuitable: json["is_suitable"],
        isAdminNote: json["is_admin_note"],
        adminNote: json["admin_note"],
        createdBy: json["created_by"],
        updatedBy: json["updated_by"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        deletedAt: json["deleted_at"] == null ? null : json["deleted_at"],
        workType: json["work_type"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "code": code,
        "project_id": projectId,
        "difficulty_id": difficultyId,
        "name": name,
        "activity_code": activityCode,
        "start_at": startAt,
        "finish_at": finishAt,
        "duration": duration,
        "duration_realization": durationRealization,
        "score": score,
        "point": point,
        "note": note,
        "executed_at": executedAt,
        "dates": dates,
        "is_active": isActive,
        "is_suitable": isSuitable,
        "is_admin_note": isAdminNote,
        "admin_note": adminNote,
        "created_by": createdBy,
        "updated_by": updatedBy,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "deleted_at": deletedAt,
        "work_type": workType,
      };
}
