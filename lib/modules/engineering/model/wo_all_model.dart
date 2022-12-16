import 'dart:convert';

class WoAllModel {
  WoAllModel({
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
    this.description,
    this.needElectrician,
    this.type,
    this.isActive,
    this.isFinish,
    this.isOvertime,
    this.approved,
    this.isAdminNote,
    this.adminNote,
    this.isSuitable,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.workType,
  });

  String? id;
  String? relationableType;
  String? relationableId;
  String? code;
  String? groupCode;
  String? machineCode;
  String? activityCode;
  int? inspectionId;
  String? executedAt;
  String? startAt;
  String? finishAt;
  int? duration;
  int? durationRealization;
  double? score;
  double? point;
  String? description;
  int? needElectrician;
  int? type;
  int? isActive;
  int? isFinish;
  int? isOvertime;
  int? approved;
  int? isAdminNote;
  String? adminNote;
  int? isSuitable;
  int? createdBy;
  int? updatedBy;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  String? workType;

  factory WoAllModel.fromJson(String str) =>
      WoAllModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory WoAllModel.fromMap(Map<dynamic, dynamic> json) => WoAllModel(
        id: json["id"],
        relationableType: json["relationable_type"],
        relationableId: json["relationable_id"],
        code: json["code"],
        groupCode: json["group_code"],
        machineCode: json["machine_code"],
        activityCode: json["activity_code"],
        inspectionId: json["inspection_id"],
        executedAt: json["executed_at"],
        startAt: json["start_at"],
        finishAt: json["finish_at"],
        duration: json["duration"],
        durationRealization: json["duration_realization"],
        score: json["score"].toDouble(),
        point: json["point"].toDouble(),
        description: json["description"],
        needElectrician: json["need_electrician"],
        type: json["type"],
        isActive: json["is_active"],
        isFinish: json["is_finish"],
        isOvertime: json["is_overtime"],
        approved: json["approved"],
        isAdminNote: json["is_admin_note"],
        adminNote: json["admin_note"],
        isSuitable: json["is_suitable"],
        createdBy: json["created_by"],
        updatedBy: json["updated_by"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        deletedAt: json["deleted_at"] == null ? null : json["deleted_at"],
        workType: json["work_type"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "relationable_type": relationableType,
        "relationable_id": relationableId,
        "code": code,
        "group_code": groupCode,
        "machine_code": machineCode,
        "activity_code": activityCode,
        "inspection_id": inspectionId,
        "executed_at": executedAt,
        "start_at": startAt,
        "finish_at": finishAt,
        "duration": duration,
        "duration_realization": durationRealization,
        "score": score,
        "point": point,
        "description": description,
        "need_electrician": needElectrician,
        "type": type,
        "is_active": isActive,
        "is_finish": isFinish,
        "is_overtime": isOvertime,
        "approved": approved,
        "is_admin_note": isAdminNote,
        "admin_note": adminNote,
        "is_suitable": isSuitable,
        "created_by": createdBy,
        "updated_by": updatedBy,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "deleted_at": deletedAt,
        "work_type": workType,
      };
}
