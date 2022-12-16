import 'package:sentra_mobile/config/sqflite_helper.dart';
import 'package:sentra_mobile/modules/engineering/model/wo_repair_model.dart';

class WoRepairRepository {
  final SQFliteHelper _sqFliteHelper = SQFliteHelper();
  String tblName = "eng_repairs";

  var columnUsable = [
    "id",
    "relationable_type",
    "relationable_id",
    "code",
    "group_code",
    "machine_code",
    "activity_code",
    "inspection_id",
    "executed_at",
    "start_at",
    "finish_at",
    "duration",
    "duration_realization",
    "score",
    "point",
    "description",
    "need_electrician",
    "type",
    "is_active",
    "is_finish",
    "is_overtime",
    "approved",
    "is_admin_note",
    "admin_note",
    "is_suitable",
    "created_by",
    "updated_by",
    "created_at",
    "updated_at",
    "deleted_at"
  ];

  Future<List<WoRepairModel>> getData() async {
    var dbClient = await _sqFliteHelper.db;
    List<Map> maps = await dbClient.rawQuery("""
    SELECT 
    DISTINCT
    c.name as activity_code, 
    a.id,
    a.relationable_type,
    a.relationable_id,
    a.code,
    a.group_code,
    a.machine_code,
    a.inspection_id,
    a.executed_at,
    a.start_at,
    a.finish_at,
    a.duration,
    a.duration_realization,
    a.score,
    a.point,
    a.description,
    a.need_electrician,
    a.type,
    a.is_active,
    a.is_finish,
    a.is_overtime,
    a.approved,
    a.is_admin_note,
    a.admin_note,
    a.is_suitable,
    a.created_by,
    a.updated_by,
    a.created_at,
    a.updated_at,
    a.deleted_at
    from eng_repairs a
    LEFT JOIN eng_activities c ON a.activity_code = c.code
    AND a.id NOT IN
    (SELECT repair_id 
     FROM eng_repair_realizations)
    ORDER BY a.start_at ASC
    """);

    List<WoRepairModel> dt = [];
    for (int i = 0; i < maps.length; i++) {
      dt.add(WoRepairModel.fromMap(maps[i]));
    }

    return dt;
  }

  Future<WoRepairModel> getDataById(String? woId) async {
    var dbClient = await _sqFliteHelper.db;
    List<Map> maps = await dbClient.rawQuery("""
    SELECT 
    c.name as activity_code, 
    a.id,
    a.relationable_type,
    a.relationable_id,
    a.code,
    a.group_code,
    a.machine_code,
    a.inspection_id,
    a.executed_at,
    a.start_at,
    a.finish_at,
    a.duration,
    a.duration_realization,
    a.score,
    a.point,
    a.description,
    a.need_electrician,
    a.type,
    a.is_active,
    a.is_finish,
    a.is_overtime,
    a.approved,
    a.is_admin_note,
    a.admin_note,
    a.is_suitable,
    a.created_by,
    a.updated_by,
    a.created_at,
    a.updated_at,
    a.deleted_at
    from eng_repairs a
    LEFT JOIN eng_activities c ON a.activity_code = c.code
    WHERE a.id = ?
    ORDER BY a.start_at ASC
    """, [woId]);

    var result;
    List<WoRepairModel> dt = [];
    if (maps.isNotEmpty) {
      dt.add(WoRepairModel.fromMap(maps[0]));
      result = dt[0];
    } else {
      result = await WoRepairModel();
    }

    return result;
  }

  Future<List<WoRepairModel>> getDataByEmp(String? empId) async {
    var dbClient = await _sqFliteHelper.db;
    List<Map> maps = await dbClient.rawQuery("""
    SELECT 
    c.name as activity_code, 
    a.id,
    a.relationable_type,
    a.relationable_id,
    a.code,
    a.group_code,
    a.machine_code,
    a.inspection_id,
    a.executed_at,
    a.start_at,
    a.finish_at,
    a.duration,
    a.duration_realization,
    a.score,
    a.point,
    a.description,
    a.need_electrician,
    a.type,
    a.is_active,
    a.is_finish,
    a.is_overtime,
    a.approved,
    a.is_admin_note,
    a.admin_note,
    a.is_suitable,
    a.created_by,
    a.updated_by,
    a.created_at,
    a.updated_at,
    a.deleted_at
    from eng_repairs a
    LEFT JOIN eng_repair_employees b ON a.id = b.repair_id
    LEFT JOIN eng_activities c ON a.activity_code = c.code
    WHERE b.employee_id = ?
    AND a.id NOT IN
    (SELECT repair_id 
     FROM eng_repair_realizations)
    AND a.id NOT IN
    (SELECT wo_id 
     FROM wo_onprogress where status = 2)
    ORDER BY a.start_at ASC
    """, [empId]);

    List<WoRepairModel> dt = [];
    for (int i = 0; i < maps.length; i++) {
      dt.add(WoRepairModel.fromMap(maps[i]));
    }

    return dt;
  }

  Future<List<WoRepairModel>> getDataByEmpOther(String? empId) async {
    var dbClient = await _sqFliteHelper.db;
    List<Map> maps = await dbClient.rawQuery("""
    SELECT 
    c.name as activity_code, 
    a.id,
    a.relationable_type,
    a.relationable_id,
    a.code,
    a.group_code,
    a.machine_code,
    a.inspection_id,
    a.executed_at,
    a.start_at,
    a.finish_at,
    a.duration,
    a.duration_realization,
    a.score,
    a.point,
    a.description,
    a.need_electrician,
    a.type,
    a.is_active,
    a.is_finish,
    a.is_overtime,
    a.approved,
    a.is_admin_note,
    a.admin_note,
    a.is_suitable,
    a.created_by,
    a.updated_by,
    a.created_at,
    a.updated_at,
    a.deleted_at
    from eng_repairs a
    LEFT JOIN eng_repair_employees b ON a.id = b.repair_id
    LEFT JOIN eng_activities c ON a.activity_code = c.code
    WHERE b.employee_id != ?
    AND a.id NOT IN
    (SELECT repair_id 
     FROM eng_repair_realizations)
    AND a.id NOT IN
    (SELECT wo_id 
     FROM wo_onprogress where status = 2)  
    ORDER BY a.start_at ASC
    """, [empId]);

    List<WoRepairModel> dt = [];
    for (int i = 0; i < maps.length; i++) {
      dt.add(WoRepairModel.fromMap(maps[i]));
    }

    return dt;
  }

  Future<List<WoRepairModel>> getDataPauseWo() async {
    var dbClient = await _sqFliteHelper.db;
    List<Map> maps = await dbClient.rawQuery("""
    SELECT 
    a.*,
    c.name as activity_code
    from eng_repairs a
    LEFT JOIN eng_activities c ON a.activity_code = c.code
    INNER JOIN wo_onprogress d ON d.wo_id = a.id
    WHERE d.status = 2
    AND a.id NOT IN
    (SELECT repair_id 
     FROM eng_repair_realizations)
    ORDER BY a.start_at ASC
    """);

    List<WoRepairModel> dt = [];
    for (int i = 0; i < maps.length; i++) {
      dt.add(WoRepairModel.fromMap(maps[i]));
    }

    return dt;
  }

  Future<WoRepairModel> getDataWo(String? id) async {
    var dbClient = await _sqFliteHelper.db;
    List<Map> maps = await dbClient.query(tblName, columns: columnUsable);
    List<WoRepairModel> dt = [];

    for (int i = 0; i < maps.length; i++) {
      dt.add(WoRepairModel.fromMap(maps[i]));
    }

    return dt[0];
  }

  Future<List<WoRepairModel>> getDataManualWo() async {
    var dbClient = await _sqFliteHelper.db;
    List<Map> maps = await dbClient.query(tblName,
        columns: columnUsable, where: "admin_note = ?", whereArgs: ['Manual']);
    List<WoRepairModel> dt = [];

    for (int i = 0; i < maps.length; i++) {
      dt.add(WoRepairModel.fromMap(maps[i]));
    }

    return dt;
  }

  Future<int> add(WoRepairModel dtModel) async {
    var dbClient = await _sqFliteHelper.db;
    return await dbClient.insert(tblName, dtModel.toMap());
  }

  Future<int> update(WoRepairModel dtModel) async {
    var dbClient = await _sqFliteHelper.db;
    return await dbClient.update(tblName, dtModel.toMap(),
        where: "id = ?", whereArgs: [dtModel.id]);
  }

  Future<int> delete(String? id) async {
    var dbClient = await _sqFliteHelper.db;
    return await dbClient.delete(tblName, where: "id = ?", whereArgs: [id]);
  }

  Future<void> turncateTable() async {
    var dbClient = await _sqFliteHelper.db;
    return await dbClient.execute("DELETE FROM ${tblName}");
  }
}
