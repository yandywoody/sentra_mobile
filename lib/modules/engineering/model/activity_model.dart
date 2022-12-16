import 'dart:convert';

class ActivityModel {
  static var obs;

  ActivityModel({
    this.id,
    this.groupCode,
    this.department,
    this.code,
    this.name,
    this.difficulty,
    this.point,
    this.score,
    this.description,
    this.isUrgent,
    this.isActive,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  String? id;
  String? groupCode;
  int? department;
  String? code;
  String? name;
  String? difficulty;
  double? point;
  double? score;
  String? description;
  int? isUrgent;
  int? isActive;
  int? createdBy;
  int? updatedBy;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;

  factory ActivityModel.fromJson(String str) =>
      ActivityModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ActivityModel.fromMap(Map<dynamic, dynamic> json) => ActivityModel(
        id: json["id"],
        groupCode: json["group_code"],
        department: json["department"],
        code: json["code"],
        name: json["name"],
        difficulty: json["difficulty"],
        point: json["point"].toDouble(),
        score: json["score"].toDouble(),
        description: json["description"] == null ? null : json["description"],
        isUrgent: json["is_urgent"] == null ? null : json["is_urgent"],
        isActive: json["is_active"] == null ? null : json["is_active"],
        createdBy: json["created_by"],
        updatedBy: json["updated_by"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        deletedAt: json["deleted_at"] == null ? null : json["deleted_at"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "group_code": groupCode,
        "department": department,
        "code": code,
        "name": name,
        "difficulty": difficulty,
        "point": point,
        "score": score,
        "description": description,
        "is_urgent": isUrgent,
        "is_active": isActive,
        "created_by": createdBy,
        "updated_by": updatedBy,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "deleted_at": deletedAt,
      };
}
