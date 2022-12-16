import 'dart:convert';

import 'package:sentra_mobile/modules/engineering/model/inspection_relation.model.dart';

class WoInspectionModel {
  WoInspectionModel({
    required this.id,
    this.relationableType,
    this.relationableId,
    this.code,
    this.groupCode,
    this.machineCode,
    this.executedAt,
    this.status,
    this.duration,
    this.durationRealization,
    this.score,
    this.point,
    this.description,
    this.isActive,
    this.isAdminNote,
    this.isSuitable,
    this.isManual,
    this.adminNote,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.workType,
    this.inspectionRelation,
  });

  String id;
  String? relationableType;
  String? relationableId;
  String? code;
  String? groupCode;
  String? machineCode;
  String? executedAt;
  int? status;
  int? duration;
  int? durationRealization;
  double? score;
  double? point;
  String? description;
  int? isActive;
  int? isAdminNote;
  int? isSuitable;
  int? isManual;
  String? adminNote;
  int? createdBy;
  int? updatedBy;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  String? workType;
  InspectionRelation? inspectionRelation;

  factory WoInspectionModel.fromJson(String str) =>
      WoInspectionModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory WoInspectionModel.fromMap(Map<dynamic, dynamic> json) =>
      WoInspectionModel(
        id: json["id"],
        relationableType: json["relationable_type"],
        relationableId: json["relationable_id"],
        code: json["code"],
        groupCode: json["group_code"],
        machineCode: json["machine_code"],
        executedAt: json["executed_at"],
        status: json["status"],
        duration: json["duration"],
        durationRealization: json["duration_realization"],
        score: json["score"] == null ? null : json["score"].toDouble(),
        point: json["score"] == null ? null : json["point"].toDouble(),
        description: json["description"],
        isActive: json["is_active"],
        isAdminNote: json["is_admin_note"],
        isSuitable: json["is_suitable"],
        isManual: json["is_manual"],
        adminNote: json["admin_note"],
        createdBy: json["created_by"],
        updatedBy: json["updated_by"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        deletedAt: json["deleted_at"] == null ? null : json["deleted_at"],
        workType: json["work_type"],
        inspectionRelation: json["relationable"] == null
            ? null
            : InspectionRelation.fromMap(json["relationable"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "relationable_type": relationableType,
        "relationable_id": relationableId,
        "code": code,
        "group_code": groupCode,
        "machine_code": machineCode,
        "executed_at": executedAt,
        "status": status,
        "duration": duration,
        "duration_realization": durationRealization,
        "score": score,
        "point": point,
        "description": description,
        "is_active": isActive,
        "is_admin_note": isAdminNote,
        "is_suitable": isSuitable,
        "is_manual": isManual,
        "admin_note": adminNote,
        "created_by": createdBy,
        "updated_by": updatedBy,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "deleted_at": deletedAt,
        "work_type": workType,
        "relationable":
            inspectionRelation == null ? null : inspectionRelation?.toMap(),
      };
}
