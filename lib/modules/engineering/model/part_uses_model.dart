import 'dart:convert';

class PartUsesModel {
  static var obs;

  PartUsesModel({
    this.id,
    this.usableType,
    this.usableId,
    this.itemId,
    this.quantity,
    this.unitConversionId,
    this.isLup,
    this.description,
    this.isActive,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  String? id;
  String? usableType;
  String? usableId;
  int? itemId;
  double? quantity;
  String? unitConversionId;
  int? isLup;
  String? description;
  int? isActive;
  int? createdBy;
  int? updatedBy;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;

  factory PartUsesModel.fromJson(String str) =>
      PartUsesModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PartUsesModel.fromMap(Map<dynamic, dynamic> json) => PartUsesModel(
        id: json["id"],
        usableId: json["usable_id"],
        usableType: json["usable_type"],
        itemId: json["item_id"],
        quantity: json["quantity"],
        unitConversionId: json["unit_conversion_id"],
        isLup: json["is_lup"],
        description: json["description"],
        isActive: json["is_active"],
        createdBy: json["created_by"],
        updatedBy: json["updated_by"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        deletedAt: json["deleted_at"] == null ? null : json["deleted_at"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "usable_id": usableId,
        "usable_type": usableType,
        "item_id": itemId,
        "quantity": quantity,
        "unit_conversion_id": unitConversionId,
        "is_lup": isLup,
        "description": description,
        "is_active": isActive,
        "created_by": createdBy,
        "updated_by": updatedBy,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "deleted_at": deletedAt,
      };
}
