import 'package:sentra_mobile/config/sqflite_helper.dart';
import 'package:sentra_mobile/modules/engineering/model/item_lups_model.dart';
import 'package:sentra_mobile/modules/engineering/model/items_model.dart';
import 'package:sentra_mobile/modules/general/model/kpi_model.dart';

class ItemsRepository {
  final SQFliteHelper _sqFliteHelper = SQFliteHelper();
  String tblName = "items";

  var columnUsable = [
    "id",
    "code",
    "item_measure_id",
    "name",
    "detail",
    "slug",
    "created_at",
    "updated_at",
    "deleted_at",
  ];

  Future<List<ItemsModel>> getData() async {
    var dbClient = await _sqFliteHelper.db;
    List<Map> maps = await dbClient.query(tblName, columns: columnUsable);
    List<ItemsModel> dt = [];

    for (int i = 0; i < maps.length; i++) {
      dt.add(ItemsModel.fromMap(maps[i]));
    }

    return dt;
  }

  Future<int> add(ItemsModel dtModel) async {
    var dbClient = await _sqFliteHelper.db;
    return await dbClient.insert(tblName, dtModel.toMap());
  }

  Future<int> update(ItemsModel dtModel) async {
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
