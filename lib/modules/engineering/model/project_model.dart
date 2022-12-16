// To parse this JSON data, do
//
//     final projectHeaderModel = projectHeaderModelFromMap(jsonString);

import 'dart:convert';

class ProjectModel {
  ProjectModel({
    this.id,
    this.priorityCode,
    this.groupCode,
    this.applicantId,
    this.leaderId,
    this.revisionFrom,
    this.code,
    this.name,
    this.location,
    this.duration,
    this.file,
    this.description,
    this.status,
    this.isApprove,
    this.isSuitable,
    this.goodsReceived,
    this.createdBy,
    this.updatedBy,
    this.verifiedBy,
    this.startDate,
    this.finishDate,
    this.completedDate,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.workType,
  });

  String? id;
  String? priorityCode;
  String? groupCode;
  String? applicantId;
  String? leaderId;
  String? revisionFrom;
  String? code;
  String? name;
  String? location;
  int? duration;
  String? file;
  String? description;
  int? status;
  int? isApprove;
  int? isSuitable;
  int? goodsReceived;
  int? createdBy;
  int? updatedBy;
  String? verifiedBy;
  String? startDate;
  String? finishDate;
  String? completedDate;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  String? workType;

  factory ProjectModel.fromJson(String str) =>
      ProjectModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ProjectModel.fromMap(Map<dynamic, dynamic> json) => ProjectModel(
        id: json["id"] == null ? null : json["id"],
        priorityCode:
            json["priority_code"] == null ? null : json["priority_code"],
        groupCode: json["group_code"] == null ? null : json["group_code"],
        applicantId: json["applicant_id"] == null ? null : json["applicant_id"],
        leaderId: json["leader_id"] == null ? null : json["leader_id"],
        revisionFrom:
            json["revision_from"] == null ? null : json["revision_from"],
        code: json["code"] == null ? null : json["code"],
        name: json["name"] == null ? null : json["name"],
        location: json["location"] == null ? null : json["location"],
        duration: json["duration"] == null ? null : json["duration"],
        file: json["file"] == null ? null : json["file"],
        description: json["description"] == null ? null : json["description"],
        status: json["status"] == null ? null : json["status"],
        isApprove: json["is_approve"] == null ? null : json["is_approve"],
        isSuitable: json["is_suitable"] == null ? null : json["is_suitable"],
        goodsReceived:
            json["goods_received"] == null ? null : json["goods_received"],
        createdBy: json["created_by"] == null ? null : json["created_by"],
        updatedBy: json["updated_by"] == null ? null : json["updated_by"],
        verifiedBy: json["verified_by"] == null ? null : json["verified_by"],
        startDate: json["start_date"] == null ? null : json["start_date"],
        finishDate: json["finish_date"] == null ? null : json["finish_date"],
        completedDate:
            json["completed_date"] == null ? null : json["completed_date"],
        createdAt: json["created_at"] == null ? null : json["created_at"],
        updatedAt: json["updated_at"] == null ? null : json["updated_at"],
        deletedAt: json["deleted_at"] == null ? null : json["deleted_at"],
        workType: json["work_type"] == null ? null : json["work_type"],
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "priority_code": priorityCode == null ? null : priorityCode,
        "group_code": groupCode == null ? null : groupCode,
        "applicant_id": applicantId == null ? null : applicantId,
        "leader_id": leaderId == null ? null : leaderId,
        "revision_from": revisionFrom == null ? null : revisionFrom,
        "code": code == null ? null : code,
        "name": name == null ? null : name,
        "location": location == null ? null : location,
        "duration": duration == null ? null : duration,
        "file": file == null ? null : file,
        "description": description == null ? null : description,
        "status": status == null ? null : status,
        "is_approve": isApprove == null ? null : isApprove,
        "is_suitable": isSuitable == null ? null : isSuitable,
        "goods_received": goodsReceived == null ? null : goodsReceived,
        "created_by": createdBy == null ? null : createdBy,
        "updated_by": updatedBy == null ? null : updatedBy,
        "verified_by": verifiedBy == null ? null : verifiedBy,
        "start_date": startDate == null ? null : startDate,
        "finish_date": finishDate == null ? null : finishDate,
        "completed_date": completedDate == null ? null : completedDate,
        "created_at": createdAt == null ? null : createdAt,
        "updated_at": updatedAt == null ? null : updatedAt,
        "deleted_at": deletedAt == null ? null : deletedAt,
        "work_type": workType == null ? null : workType,
      };
}
