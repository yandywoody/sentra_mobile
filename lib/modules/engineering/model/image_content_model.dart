import 'dart:convert';

class ImageContentModel {
  static var obs;

  ImageContentModel({
    this.id,
    this.relationalId,
    this.relationalType,
    this.path,
    this.name,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  String? id;
  String? relationalId;
  String? relationalType;
  String? finishAt;
  String? path;
  String? name;
  int? createdBy;
  int? updatedBy;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;

  factory ImageContentModel.fromJson(String str) =>
      ImageContentModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ImageContentModel.fromMap(Map<dynamic, dynamic> json) =>
      ImageContentModel(
        id: json["id"],
        relationalId: json["relational_id"],
        relationalType: json["relational_type"],
        path: json["path"],
        name: json["name"],
        createdBy: json["created_by"],
        updatedBy: json["updated_by"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        deletedAt: json["deleted_at"] == null ? null : json["deleted_at"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "relational_id": relationalId,
        "relational_type": relationalType,
        "path": path,
        "name": name,
        "created_by": createdBy,
        "updated_by": updatedBy,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "deleted_at": deletedAt,
      };
}
