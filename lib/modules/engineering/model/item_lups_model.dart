import 'dart:convert';

class ItemLupsModel {
  static var obs;

  ItemLupsModel({
    this.id,
    this.itemId,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  String? id;
  String? itemId;
  int? createdBy;
  int? updatedBy;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;

  factory ItemLupsModel.fromJson(String str) =>
      ItemLupsModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ItemLupsModel.fromMap(Map<dynamic, dynamic> json) => ItemLupsModel(
        id: json["id"],
        itemId: json["item_id"],
        createdBy: json["created_by"],
        updatedBy: json["updated_by"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        deletedAt: json["deleted_at"] == null ? null : json["deleted_at"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "item_id": itemId,
        "created_by": createdBy,
        "updated_by": updatedBy,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "deleted_at": deletedAt,
      };
}
