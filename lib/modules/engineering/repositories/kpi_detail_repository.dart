import 'package:sentra_mobile/config/sqflite_helper.dart';
import 'package:sentra_mobile/modules/general/model/kpi_detail_model.dart';

class KpiDetailRepository {
  final SQFliteHelper _sqFliteHelper = SQFliteHelper();
  String tblName = "gnr_key_performance_indicator_result_details";

  var columnUsable = [
    "id",
    "result_id",
    "code",
    "name",
    "numerator",
    "denominator",
    "category",
    "type",
    "result",
    "weight",
    "score",
    "value",
    "created_at",
    "updated_at",
  ];

  Future<List<KpiDetailModel>> getData() async {
    var dbClient = await _sqFliteHelper.db;
    List<Map> maps = await dbClient.query(tblName, columns: columnUsable);
    List<KpiDetailModel> dt = [];

    for (int i = 0; i < maps.length; i++) {
      dt.add(KpiDetailModel.fromMap(maps[i]));
    }

    return dt;
  }

  Future<List<KpiDetailModel>> getDataById(String? id) async {
    var dbClient = await _sqFliteHelper.db;
    List<Map> maps = await dbClient.query(tblName,
        columns: columnUsable, where: "result_id = ?", whereArgs: [id]);
    List<KpiDetailModel> dt = [];

    for (int i = 0; i < maps.length; i++) {
      dt.add(KpiDetailModel.fromMap(maps[i]));
    }

    return dt;
  }

  Future<int> add(KpiDetailModel dtModel) async {
    var dbClient = await _sqFliteHelper.db;
    return await dbClient.insert(tblName, dtModel.toMap());
  }

  Future<int> update(KpiDetailModel dtModel) async {
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
