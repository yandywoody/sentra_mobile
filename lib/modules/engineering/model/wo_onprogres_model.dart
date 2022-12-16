import 'dart:convert';

class WoOnProgressModel {
  static var obs;

  WoOnProgressModel({
    this.id,
    this.woId,
    this.startAt,
    this.finishAt,
    this.pauseAt,
    this.employeeId,
    this.duration,
    this.durationPause,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.workType,
  });

  int? id;
  String? woId;
  String? startAt;
  String? finishAt;
  String? pauseAt;
  String? employeeId;
  int? duration;
  int? durationPause;
  int? status;
  String? createdAt;
  String? updatedAt;
  String? workType;

  factory WoOnProgressModel.fromJson(String str) =>
      WoOnProgressModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory WoOnProgressModel.fromMap(Map<dynamic, dynamic> json) =>
      WoOnProgressModel(
        id: json["id"],
        woId: json["wo_id"],
        startAt: json["start_at"],
        pauseAt: json["pause_at"],
        finishAt: json["finish_at"],
        employeeId: json["employee_id"],
        durationPause: json["duration_pause"],
        duration: json["duration"],
        status: json["status"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        workType: json["work_type"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "wo_id": woId,
        "start_at": startAt,
        "pause_at": pauseAt,
        "finish_at": finishAt,
        "employee_id": employeeId,
        "duration_pause": durationPause,
        "duration": duration,
        "status": status,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "work_type": workType,
      };
}
