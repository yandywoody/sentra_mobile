import 'dart:convert';

class MachineModel {
  MachineModel({
    required this.id,
    this.code,
    this.machineAreaCode,
    this.machineGroupCode,
    this.serialNumber,
    this.brand,
    this.type,
    this.category,
    this.year,
    this.note,
    this.capacity,
    this.description,
    this.isDyeing,
    this.isActive,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  String id;
  String? code;
  String? machineAreaCode;
  String? machineGroupCode;
  String? serialNumber;
  String? brand;
  String? type;
  int? category;
  String? year;
  String? note;
  double? capacity;
  String? description;
  int? isDyeing;
  int? isActive;
  int? createdBy;
  int? updatedBy;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;

  factory MachineModel.fromJson(String str) =>
      MachineModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory MachineModel.fromMap(Map<dynamic, dynamic> json) => MachineModel(
        id: json["id"],
        code: json["code"],
        machineAreaCode: json["machine_area_code"],
        machineGroupCode: json["machine_group_code"],
        serialNumber:
            json["serial_number"] == null ? null : json["serial_number"],
        brand: json["brand"] == null ? null : json["brand"],
        type: json["type"] == null ? null : json["type"],
        category: json["category"],
        year: json["year"] == null ? null : json["year"],
        note: json["note"],
        capacity: json["capacity"] == null ? null : json["capacity"].toDouble(),
        description: json["description"],
        isDyeing: json["is_dyeing"],
        isActive: json["is_active"],
        createdBy: json["created_by"],
        updatedBy: json["updated_by"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        deletedAt: json["deleted_at"] == null ? null : json["deleted_at"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "code": code,
        "machine_area_code": machineAreaCode,
        "machine_group_code": machineGroupCode,
        "serial_number": serialNumber,
        "brand": brand,
        "type": type,
        "category": category,
        "year": year,
        "note": note,
        "capacity": capacity,
        "description": description,
        "is_dyeing": isDyeing,
        "is_active": isActive,
        "created_by": createdBy,
        "updated_by": updatedBy,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "deleted_at": deletedAt,
      };
}
