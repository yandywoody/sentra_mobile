import 'dart:convert';

class KpiDetailModel {
  KpiDetailModel({
    this.id,
    this.resultId,
    this.code,
    this.name,
    this.numerator,
    this.denominator,
    this.category,
    this.type,
    this.result,
    this.weight,
    this.score,
    this.value,
    this.createdAt,
    this.updatedAt,
  });

  String? id;
  String? resultId;
  String? code;
  String? name;
  String? numerator;
  String? denominator;
  String? category;
  String? type;
  num? result;
  num? weight;
  num? score;
  String? value;
  String? createdAt;
  String? updatedAt;

  factory KpiDetailModel.fromJson(String str) =>
      KpiDetailModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory KpiDetailModel.fromMap(Map<dynamic, dynamic> json) => KpiDetailModel(
        id: json["id"] == null ? null : json["id"],
        resultId: json["result_id"] == null ? null : json["result_id"],
        code: json["code"] == null ? null : json["code"],
        name: json["name"] == null ? null : json["name"],
        numerator: json["numerator"] == null ? null : json["numerator"],
        denominator: json["denominator"] == null ? null : json["denominator"],
        category: json["category"] == null ? null : json["category"],
        type: json["type"] == null ? null : json["type"],
        result: json["result"] == null ? null : json["result"],
        weight: json["weight"] == null ? null : json["weight"],
        score: json["score"] == null ? null : json["score"],
        value: json["value"] == null ? null : json["value"],
        createdAt: json["created_at"] == null ? null : (json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : (json["updated_at"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "result_id": resultId == null ? null : resultId,
        "code": code == null ? null : code,
        "name": name == null ? null : name,
        "numerator": numerator == null ? null : numerator,
        "denominator": denominator == null ? null : denominator,
        "category": category == null ? null : category,
        "type": type == null ? null : type,
        "result": result == null ? null : result,
        "weight": weight == null ? null : weight,
        "score": score == null ? null : score,
        "value": value == null ? null : value,
        "created_at": createdAt == null ? null : createdAt,
        "updated_at": updatedAt == null ? null : updatedAt,
      };
}
