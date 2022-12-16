import 'package:sentra_mobile/config/sqflite_helper.dart';
import 'package:sentra_mobile/modules/engineering/model/wo_project_realization_model.dart';

class WoProjectRealizationRepository {
  final SQFliteHelper _sqFliteHelper = SQFliteHelper();
  String tblName = "eng_project_detail_realizations";

  var columnUsable = [
    "id",
    "project_detail_id",
    "employee_id",
    "start_at",
    "finish_at",
    "duration",
    "effectivity",
    "point_effectivity",
    "point",
    "progress",
    "description",
    "created_by",
    "updated_by",
    "created_at",
    "updated_at",
    "deleted_at",
  ];

  Future<List<WoProjectRealizationModel>> getData() async {
    var dbClient = await _sqFliteHelper.db;
    List<Map> maps = await dbClient.query(tblName, columns: columnUsable);
    List<WoProjectRealizationModel> dt = [];

    for (int i = 0; i < maps.length; i++) {
      dt.add(WoProjectRealizationModel.fromMap(maps[i]));
    }

    return dt;
  }

  Future<List<WoProjectRealizationModel>> getDataByEmp(String? empId) async {
    var dbClient = await _sqFliteHelper.db;
    List<Map> maps = await dbClient.rawQuery(""" 
        SELECT a.*, b.code, '' as machine_code, c.name as activity_code, 'Project' as work_type from eng_project_detail_realizations a
        LEFT JOIN eng_project_details b ON b.id = a.project_detail_id
        LEFT JOIN eng_projects c ON c.id = b.project_id
        WHERE a.employee_id = ?
        """, [empId]);

    List<WoProjectRealizationModel> dt = [];
    for (int i = 0; i < maps.length; i++) {
      dt.add(WoProjectRealizationModel.fromMap(maps[i]));
    }

    return dt;
  }

  Future<int> add(WoProjectRealizationModel dtModel) async {
    var dbClient = await _sqFliteHelper.db;
    return await dbClient.rawInsert("""
    INSERT INTO eng_project_detail_realizations 
    (id,
    project_detail_id,
    employee_id,
    start_at,
    finish_at,
    duration,
    effectivity,
    point_effectivity,
    point,
    progress,
    description,
    created_by,
    updated_by,
    created_at,
    updated_at,
    deleted_at)
      VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
    """, [
      dtModel.id,
      dtModel.projectDetailId,
      dtModel.employeeId,
      dtModel.startAt,
      dtModel.finishAt,
      dtModel.duration,
      dtModel.effectivity,
      dtModel.pointEffectivity,
      dtModel.point,
      dtModel.progress,
      dtModel.description,
      dtModel.createdBy,
      dtModel.updatedBy,
      dtModel.createdAt,
      dtModel.updatedAt,
      dtModel.deletedAt
    ]);
  }

  Future<int> update(WoProjectRealizationModel dtModel) async {
    var dbClient = await _sqFliteHelper.db;
    return await dbClient.update(tblName, dtModel.toMap(),
        where: "id = ?", whereArgs: [dtModel.id]);
  }

  Future<int> delete(int id) async {
    var dbClient = await _sqFliteHelper.db;
    return await dbClient.delete(tblName, where: "id = ?", whereArgs: [id]);
  }

  Future<void> turncateTable() async {
    var dbClient = await _sqFliteHelper.db;
    return await dbClient.execute("DELETE FROM ${tblName}");
  }
}
