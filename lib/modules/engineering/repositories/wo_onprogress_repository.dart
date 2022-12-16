import 'package:sentra_mobile/config/sqflite_helper.dart';
import 'package:sentra_mobile/modules/engineering/model/wo_onprogres_model.dart';

class WoOnProgressRepository {
  final SQFliteHelper _sqFliteHelper = SQFliteHelper();
  String tblName = "wo_onprogress";

  var columnUsable = [
    "id",
    "wo_id",
    "start_at",
    "employee_id",
    "pause_at",
    "finish_at",
    "duration_pause",
    "duration",
    "status",
    "created_at",
    "updated_at",
    "work_type",
  ];

  Future<List<WoOnProgressModel>> getData() async {
    var dbClient = await _sqFliteHelper.db;
    List<Map> maps = await dbClient.query(tblName,
        columns: columnUsable,
        where: "status != ?",
        whereArgs: [2],
        orderBy: "status");
    List<WoOnProgressModel> dt = [];

    for (int i = 0; i < maps.length; i++) {
      dt.add(WoOnProgressModel.fromMap(maps[i]));
    }

    return dt;
  }

  Future<List<WoOnProgressModel>> getDataByEmp(String? empId) async {
    var dbClient = await _sqFliteHelper.db;
    List<Map> maps = await dbClient.rawQuery("""
    SELECT 
    a.*
    from wo_onprogress a
    WHERE a.employee_id = ?
    and a.status = 1
    """, [empId]);

    List<WoOnProgressModel> dt = [];
    for (int i = 0; i < maps.length; i++) {
      dt.add(WoOnProgressModel.fromMap(maps[i]));
    }

    return dt;
  }

  Future<List<WoOnProgressModel>> getDataPause(String? empId) async {
    var dbClient = await _sqFliteHelper.db;
    List<Map> maps = await dbClient.rawQuery("""
    SELECT 
    a.*
    from wo_onprogress a
    WHERE a.employee_id = ?
    and a.status = 2
    """, [empId]);

    List<WoOnProgressModel> dt = [];
    for (int i = 0; i < maps.length; i++) {
      dt.add(WoOnProgressModel.fromMap(maps[i]));
    }

    return dt;
  }

  Future<List<WoOnProgressModel>> getDataByWo(
      String? woId, String? workType) async {
    var dbClient = await _sqFliteHelper.db;
    List<Map> maps = await dbClient.query(tblName,
        columns: columnUsable,
        where: 'wo_id = ? AND work_type = ?',
        whereArgs: [woId, workType]);
    List<WoOnProgressModel> dt = [];

    for (int i = 0; i < maps.length; i++) {
      dt.add(WoOnProgressModel.fromMap(maps[i]));
    }

    return dt;
  }

  Future<int> add(WoOnProgressModel dtModel) async {
    var dbClient = await _sqFliteHelper.db;
    return await dbClient.insert(tblName, dtModel.toMap());
  }

  Future<int> update(WoOnProgressModel dtModel) async {
    var dbClient = await _sqFliteHelper.db;
    return await dbClient.update(tblName, dtModel.toMap(),
        where: "id = ?", whereArgs: [dtModel.id]);
  }

  Future<int> delete(int? id) async {
    var dbClient = await _sqFliteHelper.db;
    return await dbClient.delete(tblName, where: "id = ?", whereArgs: [id]);
  }

  Future<void> turncateTable() async {
    var dbClient = await _sqFliteHelper.db;
    return await dbClient.execute("DELETE FROM ${tblName}");
  }
}
