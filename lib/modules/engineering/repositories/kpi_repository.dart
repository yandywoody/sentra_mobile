import 'package:sentra_mobile/config/sqflite_helper.dart';
import 'package:sentra_mobile/modules/general/model/kpi_model.dart';

class KpiRepository {
  final SQFliteHelper _sqFliteHelper = SQFliteHelper();
  String tblName = "gnr_key_performance_indicator_results";

  var columnUsable = [
    "id",
    "employee_id",
    "period",
    "score",
    "value",
    "created_at",
    "updated_at",
  ];

  Future<List<KpiModel>> getData() async {
    var dbClient = await _sqFliteHelper.db;
    List<Map> maps = await dbClient.query(tblName, columns: columnUsable);
    List<KpiModel> dt = [];

    for (int i = 0; i < maps.length; i++) {
      dt.add(KpiModel.fromMap(maps[i]));
    }

    return dt;
  }

  Future<List<KpiModel>> getDataByEmp(String? empId) async {
    var dbClient = await _sqFliteHelper.db;
    List<Map> maps = await dbClient.query(tblName,
        columns: columnUsable,
        where: "employee_id = ?",
        whereArgs: [empId],
        orderBy: "period desc");
    List<KpiModel> dt = [];

    for (int i = 0; i < maps.length; i++) {
      dt.add(KpiModel.fromMap(maps[i]));
    }

    return dt;
  }

  Future<int> add(KpiModel dtModel) async {
    var dbClient = await _sqFliteHelper.db;
    return await dbClient.insert(tblName, dtModel.toMap());
  }

  Future<int> update(KpiModel dtModel) async {
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
