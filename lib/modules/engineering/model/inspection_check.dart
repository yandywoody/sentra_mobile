import 'dart:convert';

class InspectionCheckModel {
  InspectionCheckModel({
    required this.id,
    this.name,
    this.category,
    this.description,
    this.condition,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  String id;
  String? name;
  String? category;
  String? description;
  int? condition;
  int? createdBy;
  int? updatedBy;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;

  factory InspectionCheckModel.fromJson(String str) =>
      InspectionCheckModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory InspectionCheckModel.fromMap(Map<dynamic, dynamic> json) =>
      InspectionCheckModel(
        id: json["id"],
        name: json["name"],
        category: json["category"],
        description: json["description"],
        condition: json["condition"],
        createdBy: json["created_by"],
        updatedBy: json["updated_by"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        deletedAt: json["deleted_at"] == null ? null : json["deleted_at"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "category": category,
        "description": description,
        "condition": condition,
        "created_by": createdBy,
        "updated_by": updatedBy,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "deleted_at": deletedAt,
      };
}
