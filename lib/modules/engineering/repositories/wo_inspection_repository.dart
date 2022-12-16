import 'package:sentra_mobile/config/sqflite_helper.dart';
import 'package:sentra_mobile/modules/engineering/model/wo_inspection_model.dart';

class WoInspectionRepository {
  final SQFliteHelper _sqFliteHelper = SQFliteHelper();
  String tblName = "eng_inspections";

  var columnUsable = [
    "id",
    "relationable_type",
    "relationable_id",
    "code",
    "group_code",
    "machine_code",
    "executed_at",
    "status",
    "duration",
    "duration_realization",
    "score",
    "point",
    "description",
    "is_active",
    "is_admin_note",
    "is_suitable",
    "is_manual",
    "admin_note",
    "created_by",
    "updated_by",
    "created_at",
    "updated_at",
    "deleted_at",
    "work_type",
  ];

  Future<List<WoInspectionModel>> getData() async {
    var dbClient = await _sqFliteHelper.db;
    List<Map> maps = await dbClient.query(tblName, columns: columnUsable);
    List<WoInspectionModel> dt = [];

    for (int i = 0; i < maps.length; i++) {
      dt.add(WoInspectionModel.fromMap(maps[i]));
    }

    return dt;
  }

  Future<WoInspectionModel> getDataById(String? woId) async {
    var dbClient = await _sqFliteHelper.db;
    List<Map> maps = await dbClient.rawQuery("""
    SELECT a.* from eng_inspections a    
    WHERE a.id = ?
    """, [woId]);

    List<WoInspectionModel> dt = [];
    dt.add(WoInspectionModel.fromMap(maps[0]));
    return dt[0];
  }

  Future<List<WoInspectionModel>> getDataByEmp(String? empId) async {
    var dbClient = await _sqFliteHelper.db;
    List<Map> maps = await dbClient.rawQuery("""
    SELECT a.* from eng_inspections a
    LEFT JOIN eng_inspection_employees b ON a.id = b.inspection_id
    WHERE b.employee_id = ?
    AND a.id NOT IN
    (SELECT inspection_id 
     FROM eng_inspection_realizations)
    ORDER BY created_at ASC
    """, [empId]);

    List<WoInspectionModel> dt = [];
    for (int i = 0; i < maps.length; i++) {
      dt.add(WoInspectionModel.fromMap(maps[i]));
    }

    return dt;
  }

  Future<int> add(WoInspectionModel dtModel) async {
    var dbClient = await _sqFliteHelper.db;
    return await dbClient.rawInsert("""
    INSERT INTO eng_inspections 
      (
        id,
        relationable_type,
        relationable_id,
        code,
        group_code,
        machine_code,
        executed_at,
        status,
        duration,
        duration_realization,
        score,
        point,
        description,
        is_active,
        is_admin_note,
        is_suitable,
        is_manual,
        admin_note,
        created_by,
        updated_by,
        created_at,
        updated_at,
        deleted_at,
        work_type) 
      VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
    """, [
      dtModel.id,
      dtModel.relationableType,
      dtModel.relationableId,
      dtModel.code,
      dtModel.groupCode,
      dtModel.machineCode,
      dtModel.executedAt,
      dtModel.status,
      dtModel.duration,
      dtModel.durationRealization,
      dtModel.score,
      dtModel.point,
      dtModel.description,
      dtModel.isActive,
      dtModel.isAdminNote,
      dtModel.isSuitable,
      dtModel.isManual,
      dtModel.adminNote,
      dtModel.createdBy,
      dtModel.updatedBy,
      dtModel.createdAt,
      dtModel.updatedAt,
      dtModel.deletedAt
    ]);
  }

  Future<int> update(WoInspectionModel dtModel) async {
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
