import 'package:sentra_mobile/config/sqflite_helper.dart';
import 'package:sentra_mobile/modules/engineering/model/wo_repair_realization_model.dart';

class WoRepairRealizationRepository {
  final SQFliteHelper _sqFliteHelper = SQFliteHelper();
  String tblName = "eng_repair_realizations";

  var columnUsable = [
    "id",
    "repair_id",
    "employee_id",
    "start_at",
    "finish_at",
    "duration",
    "effectivity",
    "point_effectivity",
    "point",
    "description",
    "created_by",
    "updated_by",
    "created_at",
    "updated_at",
    "deleted_at",
  ];

  Future<List<WoRepairRealizationModel>> getData() async {
    var dbClient = await _sqFliteHelper.db;
    List<Map> maps = await dbClient.query(tblName, columns: columnUsable);
    List<WoRepairRealizationModel> dt = [];

    for (int i = 0; i < maps.length; i++) {
      dt.add(WoRepairRealizationModel.fromMap(maps[i]));
    }

    return dt;
  }

  Future<List<WoRepairRealizationModel>> getDataByEmp(String? empId) async {
    var dbClient = await _sqFliteHelper.db;
    // List<Map> maps = await dbClient.query(tblName,
    //     columns: columnUsable, where: 'employee_id = ?', whereArgs: [empId]);
    List<Map> maps = await dbClient.rawQuery(""" 
        SELECT a.*, b.code, b.machine_code, b.activity_code, 'Repair' as work_type from eng_repair_realizations a
        LEFT JOIN eng_repairs b ON b.id = a.repair_id
        WHERE a.employee_id = ?
        """, [empId]);

    List<WoRepairRealizationModel> dt = [];

    for (int i = 0; i < maps.length; i++) {
      dt.add(WoRepairRealizationModel.fromMap(maps[i]));
    }

    return dt;
  }

  Future<int> add(WoRepairRealizationModel dtModel) async {
    var dbClient = await _sqFliteHelper.db;
    return await dbClient.rawInsert("""
    INSERT INTO eng_repair_realizations 
      (id, 
      repair_id, 
      employee_id, 
      start_at, 
      finish_at, 
      duration, 
      effectivity, 
      point_effectivity, 
      point, 
      description, 
      is_finish, 
      created_by, 
      updated_by, 
      created_at, 
      updated_at, 
      deleted_at) 
      VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
    """, [
      dtModel.id,
      dtModel.repairId,
      dtModel.employeeId,
      dtModel.startAt,
      dtModel.finishAt,
      dtModel.duration,
      dtModel.effectivity,
      dtModel.pointEffectivity,
      dtModel.point,
      dtModel.description,
      dtModel.isFinish,
      dtModel.createdBy,
      dtModel.updatedBy,
      dtModel.createdAt,
      dtModel.updatedAt,
      dtModel.deletedAt
    ]);
  }

  Future<int> update(WoRepairRealizationModel dtModel) async {
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
