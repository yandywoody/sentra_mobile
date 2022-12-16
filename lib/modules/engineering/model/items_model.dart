import 'dart:convert';

class ItemsModel {
  static var obs;

  ItemsModel({
    this.id,
    this.code,
    this.itemMeasureId,
    this.name,
    this.detail,
    this.slug,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  String? id;
  String? code;
  String? itemMeasureId;
  String? name;
  String? detail;
  String? slug;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;

  factory ItemsModel.fromJson(String str) =>
      ItemsModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ItemsModel.fromMap(Map<dynamic, dynamic> json) => ItemsModel(
        id: json["id"],
        code: json["code"],
        itemMeasureId: json["item_measure_id"],
        name: json["name"],
        detail: json["detail"],
        slug: json["slug"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        deletedAt: json["deleted_at"] == null ? null : json["deleted_at"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "code": code,
        "item_measure_id": itemMeasureId,
        "name": name,
        "detail": detail,
        "slug": slug,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "deleted_at": deletedAt,
      };
}
