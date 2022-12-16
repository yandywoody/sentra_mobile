import 'package:sentra_mobile/config/sqflite_helper.dart';
import 'package:sentra_mobile/modules/engineering/model/wo_project_model.dart';

class WoProjectRepository {
  final SQFliteHelper _sqFliteHelper = SQFliteHelper();
  String tblName = "eng_project_details";

  var columnUsable = [
    "id",
    "code",
    "project_id",
    "difficulty_id",
    "name",
    "start_at",
    "finish_at",
    "duration",
    "duration_realization",
    "score",
    "point",
    "note",
    "executed_at",
    "dates",
    "is_active",
    "is_suitable",
    "is_admin_note",
    "admin_note",
    "created_by",
    "updated_by",
    "created_at",
    "updated_at",
    "deleted_at",
    "work_type",
  ];

  Future<List<WoProjectModel>> getData() async {
    var dbClient = await _sqFliteHelper.db;
    List<Map> maps = await dbClient.rawQuery("""
    SELECT 
    a.*
    from eng_project_details a
    left join eng_projects b on a.project_id = b.id    
    ORDER BY a.start_at ASC
    """);

    List<WoProjectModel> dt = [];
    for (int i = 0; i < maps.length; i++) {
      dt.add(WoProjectModel.fromMap(maps[i]));
    }

    return dt;
  }

  Future<List<WoProjectModel>> getDataPauseWo() async {
    var dbClient = await _sqFliteHelper.db;
    List<Map> maps = await dbClient.rawQuery("""
    SELECT 
    a.*
    from eng_project_details a
    LEFT JOIN wo_onprogress d ON d.wo_id = a.id
    WHERE d.status = 2
    AND a.id NOT IN
    (SELECT project_detail_id 
     FROM eng_project_detail_realizations)    
    ORDER BY a.start_at ASC
    """);

    List<WoProjectModel> dt = [];
    for (int i = 0; i < maps.length; i++) {
      dt.add(WoProjectModel.fromMap(maps[i]));
    }

    return dt;
  }

  Future<WoProjectModel> getDataById(String? woId) async {
    var dbClient = await _sqFliteHelper.db;
    List<Map> maps = await dbClient.query(tblName,
        columns: columnUsable, where: "id = ?", whereArgs: [woId]);

    var result;

    List<WoProjectModel> dt = [];
    if (maps.isNotEmpty) {
      dt.add(WoProjectModel.fromMap(maps[0]));
      result = dt[0];
    } else {
      result = await WoProjectModel();
    }

    return result;

    return dt[0];
  }

  Future<List<WoProjectModel>> getDataByEmp(String? empId) async {
    var dbClient = await _sqFliteHelper.db;
    List<Map> maps = await dbClient.rawQuery("""
    SELECT 
    a.*
    from eng_project_details a
    LEFT JOIN eng_project_detail_employees b ON a.code = b.project_detail_code
    WHERE b.employee_id = ?
    AND a.id NOT IN
    (SELECT project_detail_id 
     FROM eng_project_detail_realizations)
    AND a.id NOT IN
    (SELECT wo_id 
     FROM wo_onprogress where status = 2)
    ORDER BY a.start_at ASC
    """, [empId]);

    List<WoProjectModel> dt = [];
    for (int i = 0; i < maps.length; i++) {
      dt.add(WoProjectModel.fromMap(maps[i]));
    }

    return dt;
  }

  Future<List<WoProjectModel>> getDataByEmpOther(String? empId) async {
    var dbClient = await _sqFliteHelper.db;
    List<Map> maps = await dbClient.rawQuery("""
    SELECT 
    a.*
    from eng_project_details a
    LEFT JOIN eng_project_detail_employees b ON a.code = b.project_detail_code
    WHERE b.employee_id != ?
    ORDER BY a.start_at ASC
    """, [empId]);

    List<WoProjectModel> dt = [];
    for (int i = 0; i < maps.length; i++) {
      dt.add(WoProjectModel.fromMap(maps[i]));
    }

    return dt;
  }

  Future<int> add(WoProjectModel dtModel) async {
    var dbClient = await _sqFliteHelper.db;
    return await dbClient.rawInsert("""
    INSERT INTO eng_project_details 
    (
      id,
      code,
      project_id,
      difficulty_id,
      name,
      start_at,
      finish_at,
      duration,
      duration_realization,
      score,
      point,
      note,
      executed_at,
      dates,
      is_active,
      is_suitable,
      is_admin_note,
      admin_note,
      created_by,
      updated_by,
      created_at,
      updated_at,
      deleted_at,
      work_type
      )
      VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
    """, [
      dtModel.id,
      dtModel.code,
      dtModel.projectId,
      dtModel.difficultyId,
      dtModel.name,
      dtModel.startAt,
      dtModel.finishAt,
      dtModel.duration,
      dtModel.durationRealization,
      dtModel.score,
      dtModel.point,
      dtModel.note,
      dtModel.executedAt,
      dtModel.dates,
      dtModel.isActive,
      dtModel.isSuitable,
      dtModel.isAdminNote,
      dtModel.adminNote,
      dtModel.createdBy,
      dtModel.updatedBy,
      dtModel.createdAt,
      dtModel.updatedAt,
      dtModel.deletedAt,
      dtModel.workType,
    ]);
  }

  Future<int> update(WoProjectModel dtModel) async {
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
