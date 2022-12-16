import 'package:sentra_mobile/config/sqflite_helper.dart';
import 'package:sentra_mobile/modules/engineering/model/wo_service_model.dart';

class WoServiceRepository {
  final SQFliteHelper _sqFliteHelper = SQFliteHelper();
  String tblName = "eng_services";

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
    "need_electrician",
    "type",
    "description",
    "is_active",
    "is_finish",
    "is_overtime",
    "is_admin_note",
    "admin_note",
    "is_suitable",
    "created_by",
    "updated_by",
    "created_at",
    "updated_at",
    "deleted_at",
    "duration_actual_team",
    "work_type",
  ];

  Future<List<WoServiceModel>> getData() async {
    var dbClient = await _sqFliteHelper.db;
    List<Map> maps = await dbClient.rawQuery("""
    SELECT 
    a.*,
    c.name as activity_code
    from eng_services a
    LEFT JOIN eng_service_employees b ON a.id = b.service_id
    LEFT JOIN eng_activities c ON a.activity_code = c.code
    WHERE a.id NOT IN
    (SELECT service_id 
     FROM eng_service_realizations)
    AND a.id NOT IN
    (SELECT wo_id 
     FROM wo_onprogress where status = 2)  
    ORDER BY a.start_at ASC
    """);

    List<WoServiceModel> dt = [];
    for (int i = 0; i < maps.length; i++) {
      dt.add(WoServiceModel.fromMap(maps[i]));
    }

    return dt;
  }

  Future<List<WoServiceModel>> getDataByEmpOther(String? empId) async {
    var dbClient = await _sqFliteHelper.db;
    List<Map> maps = await dbClient.rawQuery("""
    SELECT 
    a.*,
    c.name as activity_code
    from eng_services a
    LEFT JOIN eng_service_employees b ON a.id = b.service_id
    LEFT JOIN eng_activities c ON a.activity_code = c.code
    WHERE b.employee_id != ?
    AND a.id NOT IN
    (SELECT service_id 
     FROM eng_service_realizations)
    AND a.id NOT IN
    (SELECT wo_id 
     FROM wo_onprogress where status = 2)   
    ORDER BY a.start_at ASC
    """, [empId]);

    List<WoServiceModel> dt = [];
    for (int i = 0; i < maps.length; i++) {
      dt.add(WoServiceModel.fromMap(maps[i]));
    }

    return dt;
  }

  Future<List<WoServiceModel>> getDataPauseWo() async {
    var dbClient = await _sqFliteHelper.db;
    List<Map> maps = await dbClient.rawQuery("""
    SELECT 
    a.*,
    c.name as activity_code
    from eng_services a
    LEFT JOIN eng_activities c ON a.activity_code = c.code
    LEFT JOIN wo_onprogress d ON d.wo_id = a.id
    WHERE d.status = 2
    AND a.id NOT IN
    (SELECT service_id 
     FROM eng_service_realizations)    
    ORDER BY a.start_at ASC
    """);

    List<WoServiceModel> dt = [];
    for (int i = 0; i < maps.length; i++) {
      dt.add(WoServiceModel.fromMap(maps[i]));
    }

    return dt;
  }

  Future<WoServiceModel> getDataById(String? woId) async {
    var dbClient = await _sqFliteHelper.db;
    List<Map> maps = await dbClient.rawQuery("""
    SELECT 
    c.name as activity_code, 
    a.*
    from eng_services a
    LEFT JOIN eng_activities c ON a.activity_code = c.code
    WHERE a.id = ?
    ORDER BY a.start_at ASC
    """, [woId]);

    var result;
    List<WoServiceModel> dt = [];
    if (maps.isNotEmpty) {
      dt.add(WoServiceModel.fromMap(maps[0]));
      result = dt[0];
    } else {
      result = await WoServiceModel();
    }

    return result;
  }

  Future<List<WoServiceModel>> getDataByEmp(String? empId) async {
    var dbClient = await _sqFliteHelper.db;
    List<Map> maps = await dbClient.rawQuery("""
    SELECT 
    a.*,
    c.name as activity_code,
    c.difficulty
    from eng_services a
    LEFT JOIN eng_service_employees b ON a.id = b.service_id
    LEFT JOIN eng_activities c ON a.activity_code = c.code
    WHERE b.employee_id = ?
    AND a.id NOT IN
    (SELECT service_id 
     FROM eng_service_realizations)
    AND a.id NOT IN
    (SELECT wo_id 
     FROM wo_onprogress where status = 2)  
    ORDER BY a.start_at ASC
    """, [empId]);

    List<WoServiceModel> dt = [];
    for (int i = 0; i < maps.length; i++) {
      dt.add(WoServiceModel.fromMap(maps[i]));
    }

    return dt;
  }

  Future<WoServiceModel> getDataWo(String? id) async {
    var dbClient = await _sqFliteHelper.db;
    List<Map> maps = await dbClient.query(tblName, columns: columnUsable);
    List<WoServiceModel> dt = [];

    for (int i = 0; i < maps.length; i++) {
      dt.add(WoServiceModel.fromMap(maps[i]));
    }

    return dt[0];
  }

  Future<List<WoServiceModel>> getDataManualWo() async {
    var dbClient = await _sqFliteHelper.db;
    List<Map> maps = await dbClient.query(tblName,
        columns: columnUsable, where: "admin_note = ?", whereArgs: ['Manual']);
    List<WoServiceModel> dt = [];

    for (int i = 0; i < maps.length; i++) {
      dt.add(WoServiceModel.fromMap(maps[i]));
    }

    return dt;
  }

  Future<int> add(WoServiceModel dtModel) async {
    var dbClient = await _sqFliteHelper.db;
    return await dbClient.insert(tblName, dtModel.toMap());
  }

  Future<int> update(WoServiceModel dtModel) async {
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
