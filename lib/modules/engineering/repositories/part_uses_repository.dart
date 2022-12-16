import 'package:sentra_mobile/config/sqflite_helper.dart';
import 'package:sentra_mobile/modules/engineering/model/part_uses_model.dart';
import 'package:sentra_mobile/modules/general/model/kpi_model.dart';

class PartUsesRepository {
  final SQFliteHelper _sqFliteHelper = SQFliteHelper();
  String tblName = "eng_part_uses";

  var columnUsable = [
    "id",
    "usable_id",
    "usable_type",
    "item_id",
    "quantity",
    "unit_conversion_id",
    "is_lup",
    "description",
    "is_active",
    "created_by",
    "updated_by",
    "created_at",
    "updated_at",
    "deleted_at",
  ];

  Future<List<PartUsesModel>> getData() async {
    var dbClient = await _sqFliteHelper.db;
    List<Map> maps = await dbClient.query(tblName, columns: columnUsable);
    List<PartUsesModel> dt = [];

    for (int i = 0; i < maps.length; i++) {
      dt.add(PartUsesModel.fromMap(maps[i]));
    }

    return dt;
  }

  Future<int> add(PartUsesModel dtModel) async {
    var dbClient = await _sqFliteHelper.db;
    return await dbClient.insert(tblName, dtModel.toMap());
  }

  Future<int> update(PartUsesModel dtModel) async {
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
