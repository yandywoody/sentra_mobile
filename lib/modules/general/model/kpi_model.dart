import 'dart:convert';

class KpiModel {
  KpiModel({
    this.id,
    this.employeeId,
    this.period,
    this.score,
    this.value,
    this.createdAt,
    this.updatedAt,
  });

  String? id;
  String? employeeId;
  String? period;
  double? score;
  String? value;
  String? createdAt;
  String? updatedAt;

  factory KpiModel.fromJson(String str) => KpiModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory KpiModel.fromMap(Map<dynamic, dynamic> json) => KpiModel(
        id: json["id"] == null ? null : json["id"],
        employeeId: json["employee_id"] == null ? null : json["employee_id"],
        period: json["period"] == null ? null : json["period"],
        score: json["score"] == null ? null : json["score"].toDouble(),
        value: json["value"] == null ? null : json["value"],
        createdAt: json["created_at"] == null ? null : json["created_at"],
        updatedAt: json["updated_at"] == null ? null : json["updated_at"],
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "employee_id": employeeId == null ? null : employeeId,
        "period": period == null ? null : period,
        "score": score == null ? null : score,
        "value": value == null ? null : value,
        "created_at": createdAt == null ? null : createdAt,
        "updated_at": updatedAt == null ? null : updatedAt,
      };
}
