import 'dart:convert';

import 'package:sentra_mobile/modules/engineering/model/realization_model.dart';

class InspectionRelation {
  InspectionRelation({
    this.id,
    this.relationableType,
    this.relationableId,
    this.code,
    this.groupCode,
    this.machineCode,
    this.activityCode,
    this.inspectionId,
    this.executedAt,
    this.startAt,
    this.finishAt,
    this.duration,
    this.durationRealization,
    this.score,
    this.point,
    this.needElectrician,
    this.type,
    this.description,
    this.isActive,
    this.isFinish,
    this.isOvertime,
    this.isAdminNote,
    this.adminNote,
    this.isSuitable,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.durationActualTeam,
    this.workType,
    this.realization,
  });

  String? id;
  String? relationableType;
  String? relationableId;
  String? code;
  String? groupCode;
  String? machineCode;
  String? activityCode;
  String? inspectionId;
  String? executedAt;
  String? startAt;
  String? finishAt;
  int? duration;
  int? durationRealization;
  num? score;
  num? point;
  int? needElectrician;
  int? type;
  String? description;
  int? isActive;
  int? isFinish;
  int? isOvertime;
  int? isAdminNote;
  String? adminNote;
  int? isSuitable;
  int? createdBy;
  int? updatedBy;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  int? durationActualTeam;
  String? workType;
  List<RealizationModel>? realization;

  factory InspectionRelation.fromJson(String str) =>
      InspectionRelation.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory InspectionRelation.fromMap(Map<String, dynamic> json) =>
      InspectionRelation(
        id: json["id"] == null ? null : json["id"],
        relationableType: json["relationable_type"],
        relationableId: json["relationable_id"],
        code: json["code"] == null ? null : json["code"],
        groupCode: json["group_code"] == null ? null : json["group_code"],
        machineCode: json["machine_code"] == null ? null : json["machine_code"],
        activityCode:
            json["activity_code"] == null ? null : json["activity_code"],
        inspectionId: json["inspection_id"],
        executedAt: json["executed_at"] == null ? null : json["executed_at"],
        startAt: json["start_at"] == null ? null : json["start_at"],
        finishAt: json["finish_at"] == null ? null : json["finish_at"],
        duration: json["duration"] == null ? null : json["duration"],
        durationRealization: json["duration_realization"] == null
            ? null
            : json["duration_realization"],
        score: json["score"] == null ? null : json["score"],
        point: json["point"] == null ? null : json["point"],
        needElectrician: json["need_electrician"],
        type: json["type"] == null ? null : json["type"],
        description: json["description"] == null ? null : json["description"],
        isActive: json["is_active"] == null ? null : json["is_active"],
        isFinish: json["is_finish"] == null ? null : json["is_finish"],
        isOvertime: json["is_overtime"] == null ? null : json["is_overtime"],
        isAdminNote:
            json["is_admin_note"] == null ? null : json["is_admin_note"],
        adminNote: json["admin_note"],
        isSuitable: json["is_suitable"],
        createdBy: json["created_by"] == null ? null : json["created_by"],
        updatedBy: json["updated_by"] == null ? null : json["updated_by"],
        createdAt: json["created_at"] == null ? null : json["executed_at"],
        updatedAt: json["updated_at"] == null ? null : json["executed_at"],
        deletedAt: json["deleted_at"],
        durationActualTeam: json["duration_actual_team"] == null
            ? null
            : json["duration_actual_team"],
        workType: json["work_type"] == null ? null : json["work_type"],
        realization: json["realizations"] == null
            ? null
            : List<RealizationModel>.from(
                json["realizations"].map((x) => RealizationModel.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "relationable_type": relationableType,
        "relationable_id": relationableId,
        "code": code == null ? null : code,
        "group_code": groupCode == null ? null : groupCode,
        "machine_code": machineCode == null ? null : machineCode,
        "activity_code": activityCode == null ? null : activityCode,
        "inspection_id": inspectionId,
        "executed_at": executedAt == null ? null : executedAt,
        "start_at": startAt == null ? null : startAt,
        "finish_at": finishAt == null ? null : finishAt,
        "duration": duration == null ? null : duration,
        "duration_realization":
            durationRealization == null ? null : durationRealization,
        "score": score == null ? null : score,
        "point": point == null ? null : point,
        "need_electrician": needElectrician,
        "type": type == null ? null : type,
        "description": description == null ? null : description,
        "is_active": isActive == null ? null : isActive,
        "is_finish": isFinish == null ? null : isFinish,
        "is_overtime": isOvertime == null ? null : isOvertime,
        "is_admin_note": isAdminNote == null ? null : isAdminNote,
        "admin_note": adminNote,
        "is_suitable": isSuitable,
        "created_by": createdBy == null ? null : createdBy,
        "updated_by": updatedBy == null ? null : updatedBy,
        "created_at": createdAt == null ? null : createdAt,
        "updated_at": updatedAt == null ? null : updatedAt,
        "deleted_at": deletedAt,
        "duration_actual_team":
            durationActualTeam == null ? null : durationActualTeam,
        "work_type": workType == null ? null : workType,
        "realizations": realization == null ? null : realization,
      };
}
