import 'package:sentra_mobile/config/sqflite_helper.dart';
import 'package:sentra_mobile/modules/engineering/model/item_lups_model.dart';
import 'package:sentra_mobile/modules/general/model/kpi_model.dart';

class ItemLupsRepository {
  final SQFliteHelper _sqFliteHelper = SQFliteHelper();
  String tblName = "eng_item_lups";

  var columnUsable = [
    "id",
    "item_id",
    "created_by",
    "updated_by",
    "created_at",
    "updated_at",
    "deleted_at",
  ];

  Future<List<ItemLupsModel>> getData() async {
    var dbClient = await _sqFliteHelper.db;
    List<Map> maps = await dbClient.query(tblName, columns: columnUsable);
    List<ItemLupsModel> dt = [];

    for (int i = 0; i < maps.length; i++) {
      dt.add(ItemLupsModel.fromMap(maps[i]));
    }

    return dt;
  }

  Future<int> add(ItemLupsModel dtModel) async {
    var dbClient = await _sqFliteHelper.db;
    return await dbClient.insert(tblName, dtModel.toMap());
  }

  Future<int> update(ItemLupsModel dtModel) async {
    var dbClient = await _sqFliteHelper.db;
    return await dbClient.update(tblName, dtModel.toMap(),
        where: "id = ?", whereArgs: [dtModel.id]);
  }

  Future<int> delete(String? id) async {
    var dbClient = await _sqFliteHelper.db;
    return await dbClient
        .delete(tblName, where: "item_id = ?", whereArgs: [id]);
  }

  Future<void> turncateTable() async {
    var dbClient = await _sqFliteHelper.db;
    return await dbClient.execute("DELETE FROM ${tblName}");
  }
}
