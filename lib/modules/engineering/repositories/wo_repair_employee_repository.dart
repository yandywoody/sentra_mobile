import 'package:sentra_mobile/config/sqflite_helper.dart';
import 'package:sentra_mobile/model/employee_model.dart';
import 'package:sentra_mobile/modules/engineering/model/wo_repair_employee_model.dart';

class WoRepairEmployeeRepository {
  final SQFliteHelper _sqFliteHelper = SQFliteHelper();
  String tblName = "eng_repair_employees";

  var columnUsable = [
    "id",
    "repair_id",
    "employee_id",
    "created_by",
    "updated_by",
    "created_at",
    "updated_at",
    "deleted_at",
  ];

  Future<List<WoRepairEmployeeModel>> getData() async {
    var dbClient = await _sqFliteHelper.db;
    List<Map> maps = await dbClient.query(tblName, columns: columnUsable);
    List<WoRepairEmployeeModel> dt = [];

    for (int i = 0; i < maps.length; i++) {
      dt.add(WoRepairEmployeeModel.fromMap(maps[i]));
    }

    return dt;
  }

  Future<List<WoRepairEmployeeModel>> getDataChange() async {
    var dbClient = await _sqFliteHelper.db;
    List<Map> maps = await dbClient.rawQuery(""" 
    SELECT a.*, b.name as employee_id from eng_repair_employees a
    INNER JOIN hr_employees b ON b.id = a.employee_id
    """);
    List<WoRepairEmployeeModel> dt = [];

    for (int i = 0; i < maps.length; i++) {
      dt.add(WoRepairEmployeeModel.fromMap(maps[i]));
    }

    return dt;
  }

  Future<List<EmployeeModel>> getEmpByWo(String? woId) async {
    var dbClient = await _sqFliteHelper.db;
    List<Map> maps = await dbClient.rawQuery(""" 
    SELECT a.* from hr_employees a
    INNER JOIN eng_repair_employees b ON a.id = b.employee_id
    WHERE b.repair_id = ?
    """, [woId]);
    List<EmployeeModel> dt = [];

    for (int i = 0; i < maps.length; i++) {
      dt.add(EmployeeModel.fromMap(maps[i]));
    }

    return dt;
  }

  Future<int> add(WoRepairEmployeeModel dtModel) async {
    var dbClient = await _sqFliteHelper.db;
    return await dbClient.insert(tblName, dtModel.toMap());
  }

  Future<int> update(WoRepairEmployeeModel dtModel) async {
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
