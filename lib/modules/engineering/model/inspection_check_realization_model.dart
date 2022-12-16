import 'dart:convert';

class InspectionCheckRealizationModel {
  static var obs;

  InspectionCheckRealizationModel({
    this.id,
    this.inspectionId,
    this.inspectionCheckId,
    this.condition,
    this.description,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  String? id;
  String? inspectionId;
  String? inspectionCheckId;
  int? condition;
  String? description;
  int? createdBy;
  int? updatedBy;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;

  factory InspectionCheckRealizationModel.fromJson(String str) =>
      InspectionCheckRealizationModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory InspectionCheckRealizationModel.fromMap(Map<dynamic, dynamic> json) =>
      InspectionCheckRealizationModel(
        id: json["id"],
        inspectionId: json["inspection_id"],
        inspectionCheckId: json["inspection_check_id"],
        condition: json["condition"],
        description: json["description"],
        createdBy: json["created_by"],
        updatedBy: json["updated_by"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        deletedAt: json["deleted_at"] == null ? null : json["deleted_at"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "inspection_id": inspectionId,
        "inspection_check_id": inspectionCheckId,
        "condition": condition,
        "description": description,
        "created_by": createdBy,
        "updated_by": updatedBy,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "deleted_at": deletedAt,
      };
}
